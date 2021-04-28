local class = require 'class'
local Collector = require 'collector'
return class {
    constructor = function(self, options, filter)
        assert(options.channel);

        self.options = options;
        self.filter = options.filter or filter or function() return true; end;

        client:on('messageCreate', function(msg)
            if msg.channel.id == self.options.channel.id then
                if not self.active then return; end;
                if self.filter(msg) then
                    self:emit('collect', msg);
                end
            end
        end);

        client:on('messageDelete', function(msg)
            if msg.channel.id == self.options.channel.id then
                if not self.active then return; end;
                if self.filter(msg) then
                    self:emit('remove', msg);
                end
            end
        end);
    end;

    extends = function(self)
        return Collector(self.filter, self.options);
    end;
}