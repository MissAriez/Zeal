local Class = require 'class';
return Class {
    constructor = function(self, precache)
        self.Cache = precache or {};

        self.__mt.__tostring = function()
            return p(self.Cache)
        end;
    end,

    push = function(self, key, value)
        self.Cache[key]:push(value)
    end;

    toArray = function(self)
        assert(self, 'use : operator instead of . with class objects');
        return self.Cache;
    end,

    size = function(self)
        assert(self, 'use : operator instead of . with class objects');
        local count = 0;
        for _, cmdObj in pairs(self:toArray()) do
            count = count + 1;
        end
        return count;
    end,

    find = function(self, predicate)
        assert(predicate);
        return table.some(self.Cache, predicate) or nil;
    end,

    get = function(self, key)
        return self.Cache[key] or nil;
    end,

    set = function(self, key, val)
        if not key then return end;
        self.Cache[key] = val;
    end,

    delete = function(self, key)
        if not key then return end;
        self:set(key, nil)
    end,

    deleteall = function(self)
        assert(self, 'use : operator instead of . with class objects');
        self.Cache = {};
    end
}