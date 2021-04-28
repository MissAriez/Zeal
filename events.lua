local Discord = require 'discordia'
local Embed = require 'embed-constructor'
local MessageCollector = require 'message-collector'
local ReactionCollector = require 'reaction-collector'
local Questioner = require 'question'
local request = require 'request'
local roman = require 'roman'
local ordinal = require 'ordinal'
local Giphy = require 'giphy'
local giphy = Giphy(env.GIPHY)
local function giphy_util(query)
  return giphy:search(query)
end
Error = require './error'
local handle_levels = require './level-handler'

return {
    ready = function()
        print 'Zeal is online.'
    end;
    messageCreate = function(msg)
        local content = msg.content
        local prefix = settings.prefix

        if msg.author.bot then return end

       local gain_formula =  handle_levels(msg)

        if not content:startswith(prefix) then return end

        local broken = content:split(prefix)[2] --this should be all of the text just without the prefix
        local args = Array(broken:split ' ')
        local cmd = args:first():lower() --this should be of course the command
        args = args:shift()

        local function parse()
            if not cmd or #cmd == 0 then return end
            local command = client._commands:get(cmd) or client._commands:get(client._aliases:get(cmd))
            if not command then return end
            
            local usage
            if command.usage:find '<none>' then
                usage = {}
            else
                usage = command.usage:split ' ' --split each argument for usage (i.e. <pageNumber> <query> becomes {'<pageNumber>', '<query>'})
            end

            if #args < #usage and not command.optionalargs then
                return msg.channel:send('You need '..#usage - #args..' more arguments for this command! Usage: `'..settings.prefix..command.name..' '..command.usage..'`')
            end

            local run = false
            if not msg.author.id == settings.author and cmd.perms ~= nil then 
                if not msg.member:hasPermission 'ADMINISTRATOR' and command.perms == 'admin' then
                    return msg:reply 'You need to be admin to run this command! :x:'
                elseif command.perms == 'bot owner' then
                    return msg:reply 'You need to be the author of this bot to run this command! :x:'
                else
                    run = true
                end
            else
                run = true
            end

            if run == false then return end

            local util = {
                Embed = Embed;
                MessageCollector = MessageCollector;
                ReactionCollector = ReactionCollector;
                Questioner = Questioner;
                Discord = Discord;
                request = request;
                Error = Error;
                gain_formula = gain_formula;
                roman = roamn;
                ordinal = ordinal;
                giphy = giphy_util;

            }

            coroutine.spawn(command.run, msg, args, util)
        end

        parse() --finally parse the command
    end;
}