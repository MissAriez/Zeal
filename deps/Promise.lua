local Class = require 'class';
local Array = require 'Array'
local unpack = table.unpack;

local promiseId = 0;

local Promise;
Promise = Class 'Promise' {
    constructor = function(self, fn)
        self.status = 'pending';
        self.resolved = false;
        self.res = Array(table.pack(pcall(function() return { fn() }; end)));
        self.ran = self.res:first();
        self.res = self.res:shift();

        promiseId = promiseId + 1;
        self.id = promiseId;
    end,
    await = function(self)
        self.resolved = true;
        self.status = 'fulfilled';
        return self.res:unpack();
    end,
    catch = function(self, handler)
        handler = handler or print;
        if self.ran == false then
            self.status = 'rejected';
            return handler(self.res:unpack());
        end
    end,
    next = function(self, callback)
        return Promise(function()
            return callback(self.res:unpack());
        end);
    end
}

return Promise;