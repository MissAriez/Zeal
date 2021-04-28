local class = require 'class'
local MessageCollector = require 'message-collector'
local Promise = require 'Promise'
local Array = require 'Array'
local timer = require 'timer'

local function wait(time)
    return timer.sleep(time * 1000);
end

return class {
    constructor = function(self, options)
        local answers, timeout, channel, user = options['answers'] or {}, options['time'] or 15, options['channel'], options['user']
        local escape = options.escape or function(m)
            answers:forEach(function(ans)
                if m.content:lower():startswith(ans) or m.content:lower() == ans then return ans; end;
            end)
        end; --stop the collector on condition escape(@params);
        assert(channel and user);
        answers = Array(answers);
        local filter = function(m) return m.author == user; end; --filter messages only made by the user
        
        self.filter = filter;
        self.escape = escape;
        self.answers = answers;
        self.timeout = timeout;
        self.channel = channel;
        self.response = nil;

        self.collector = MessageCollector {
            time = self.timeout,
            channel = self.channel,
            escape = self.escape,
            filter = self.filter
        };
    end;

    ask = function(self, question)
        self.channel:send(question);

        self.collector:on('collect', function(m)
            if self.filter(m) then
                if self.escape(m) then
                    self.response = m;
                    self.collector:stop();
                end
            end
        end);

        while self.collector.active do
            wait(.25);
            if self.response ~= nil then break; end;
        end

        if self.response == nil then
            self.response = false;
        end

        return Promise(function()
            return self.response;
        end);
    end;
}