local class = require 'class'
local Array = require 'Array'
local timer = require 'timer'
local Discord = require 'discordia'
local Emitter = Discord.Emitter

local function wait(time)
    return timer.sleep(time * 1000);
end

return class {
    constructor = function(self, filter, options)
        options = options or {};
        filter = filter or function(m)
            return true;
        end

        self.emitter = Emitter();
        self.cache = Array();
        self.options = options;
        self.filter = filter;
        self.active = true;

        self.emitter:on('collect', function(m)
            if not self.active then return; end;
            if self.filter(m) then
                self.cache:push(m);
            end
        end);

        self.emitter:on('remove', function(m)
            if not self.active then return; end;
            if self.filter(m) then
                self.cache:remove(m);
            end
        end);

        coroutine.spawn(function()
            wait(options.time or 30);
            if not self.active then return; end;
            self:stop();
        end);
    end;

    on = function(self, event, callback)
        if not self.active then return; end;
        return self.emitter:on(event, callback);
    end;

    emit = function(self, event, ...)
        return self.emitter:emit(event, ...);
    end;

    stop = function(self)
        self.emitter:emit('end', self.cache);
        self.active = false;
        self.cache = Array();
    end;
}