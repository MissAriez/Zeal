--[[lit-meta
  name = "Runic/embed-constructor@1.0.0"
  version = "1.0.0"
  homepage = ""
  description = "Lua version of Discord.Js embed constructor class for Discordia."
  tags = {"discordia"}
  license = "MIT"
  author = { name = "Riley Peel" }
]]

local Class = require 'class';
local Discord = require 'discordia';
local Date = Discord.Date;

--return function(Date)
    local Message = Class {
        constructor = function(self)
			coroutine.spawn(function()
				self.embed = {
					fields = {
							
					}
				}
			end);
        end
    }
	
	local function finish(self)
        return self.Message
    end

    return Class {
        constructor = function(self, options)
			coroutine.spawn(function()
				self.Message = Message();
			end);
			if options then
				self.Message.embed = options;
				return self.Message;
			end
				
			local function getl(t)
				return #t + 1;
			end

			function self:makeEmbed(property, val)
				coroutine.spawn(function()
					self.Message.embed[property] = val;
				end);
				return self;
			end			
        end,
        setTitle = function(self, title)
            return self:makeEmbed('title', title);
        end,
        setDescription = function(self, desc)
            return self:makeEmbed('description', desc);
        end,
        setFooter = function(self, text, icon_url)
            return self:makeEmbed('footer', {
                text = text,
                icon_url = icon_url
            });
        end,
        setURL = function(self, url)
            return self:makeEmbed('url', url);
        end,
        setAuthor = function(self, name, url, icon_url)
            return self:makeEmbed('author', {
                name = name,
                icon_url = icon_url,
                url = url
            });
        end,
        setThumbnail = function(self, url)
            return self:makeEmbed('thumbnail', {
                url = url
            });
        end,
        addFields = function(self, ...)
            self.Message.embed.fields = table.merge(self.Message.embed.fields, { ... });
            return self;
        end,
        addField = function(self, name, value, inline)
			coroutine.spawn(function()
				local field = {
					name = nil,
					value = nil,
					inline = nil
				};

				if name then
					if not value then return self; end;
					field.name = name;
				end
				if value then
					field.value = value;
				end
				if inline then
					field.inline = inline;
				end
				
				table.push(self.Message.embed.fields, field); --add a new field
			end);
            
            return self;
        end,
        setImage = function(self, url)
            return self:makeEmbed('image', {
                url = url
            });
        end,
        setIcon = function(self, url)
            return self:makeEmbed('image', {
                url = url
            });
        end,
        setColor = function(self, color)
            if type(color) == 'number' then return end;
            if type(color) == 'string' and color:lower() == 'red' then color = 0xff0000; end;
            if color == 'random' or color == nil then
				coroutine.spawn(function()
					local colors = {
						0xff0000,
						0xffa001,
						0xfff000,
						0xaaff11,
						0xaaafff,
						0x00ff00,
						0x0000ff,
						0x11aaaa,
						0x9900ff
					};
					color = table.random(colors);
				end);
                return self:makeEmbed('color', color);
            end
            return self:makeEmbed('color', color);
        end,
        setTimestamp = function(self)
            return self:makeEmbed('timestamp', Date():toISO('T', 'Z'));
        end,
        Finish = finish,
        finish = finish
    }
--end