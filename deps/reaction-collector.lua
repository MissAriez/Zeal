local class = require 'class'
local Collector = require 'collector'
return class {
    constructor = function(self, options, filter)
        assert(options.message);

        self.options = options;
        self.filter = options.filter or filter or function() return true; end;

        client:on('reactionAdd', function(reaction, userid)
            if reaction.message.id == options.message.id then
                if not self.active then return; end;
                if self.filter(reaction) then
                    self:emit('collect', reaction, reaction.message.guild:getMember(userid));
                end
            end
        end);

        client:on('reactionRemove', function(reaction, userid)
            if reaction.message.id == options.message.id then
                if not self.active then return; end;
                if self.filter(reaction) then
                    self:emit('remove', reaction, reaction.message.guild:getMember(userid));
                end
            end
        end);
    end;

    extends = function(self)
        return Collector(self.filter, self.options);
    end;
}