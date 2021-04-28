local pp = require 'pretty-print'

return Command 'lua'
    :setDesc 'Returns the output of Lua code, if any.'
    :setCategory 'Bot Author'
    :setPerms 'bot owner'
    :setUsage '<source>'
    :setAliases { 'luvit', 'sandbox' }
    :run(function(msg, args, util)
        local source = args:join ' ':gsub('`lua', ''):gsub('`', ''):gsub('\n', ' ')
        local sandbox = setmetatable({
            msg = msg;
            args = args;
            util = util;
            require = require;
        }, { __index = _G })

        local function printLine(...)
            local ret = {}
            for i = 1, select('#', ...) do
                local arg = tostring(select(i, ...))
                table.insert(ret, arg)
            end
            return table.concat(ret, '\t')
        end

        local function prettyLine(...)
            local ret = {}
            for i = 1, select('#', ...) do
                local arg = pp.strip(pp.dump(select(i, ...)))
                table.insert(ret, arg)
            end
            return table.concat(ret, '\t')
        end

        local function exec()
            local lines = {}

            sandbox.print = function(...)
                table.insert(lines, printLine(...))
            end

            sandbox.p = function(...)
                table.insert(lines, prettyLine(...))
            end
            
            local fn, err = load(source, 'Zeal', 't', sandbox)
            if not fn then return msg:reply(util.Error(err)) end

            local success, err = pcall(fn)
            if not success then return msg:reply(util.Error(err)) end

            lines = table.concat(lines, '\n')
            msg:reply(lines)
        end

        exec()
    end);