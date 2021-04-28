local Class = require 'class';

local Array;
Array = Class {
    constructor = function(self, precache)
        if precache and type(precache) ~= 'table' then error('invalid precache type "'..type(precache)..'"') end
        if precache and precache.__mt then precache = precache.cache or precache.Cache end
        self.cache = precache or {};     
        
        function self.__mt.__pairs()
            return pairs(self.cache);
        end
        function self.__mt.__ipairs()
            return ipairs(self.cache);
        end
        function self.__mt.__newindex(self,k,v)
            self.cache[k] = v
        end
        function self.__mt.__len()
            return table.deepcount(self.cache);
        end
        function self.__mt.__tostring()
            return p(self.cache);
        end
        function self.__mt.__index(self,k)
            return self.cache[k]
        end;
    end,

    length = function(self)
        return #self;
    end,
    
    push = function(self, ...)
        return Array(table.push(self.cache, ...));
    end,
    
    some = function(self, predicate)
        return table.some(self.cache, predicate);
    end,
    
    merge = function(self, ...)
        return Array(table.merge(self.cache, ...));
    end,
    
    shift = function(self)
        return Array(table.shift(self.cache));
    end,
    
    filter = function(self, predicate)
        return Array(table.filter(self.cache, predicate));
    end,
    
    first = function(self)
        return table.first(self.cache) or nil;
    end,

    last = function(self)
        local count = 0;
        local last;
        for i, v in pairs(self) do
            count = count + 1
            if count == #self then last = v; break; end;
        end;
        return last;
    end,
    
    random = function(self)
        return table.random(self.cache);
    end,

    join = function(self, delimiter)
        return table.concat(self.cache, delimiter);
    end,
    
    forEach = function(self, predicate)
        return table.forEach(self.cache, predicate);
    end,

    unpack = function(self)
        return table.unpack(self.cache);
    end,

    remove = function(self, val)
        local newarr = Array(self.cache);
        newarr:forEach(function(v, i)
            if v == val then
                self.cache[i] = nil;
            end
        end);
        return newarr;
    end,

    append = function(self, val)
        for i, v in pairs(self) do
            self[i+1] = v; --shift each val 1 index up
        end
        self[1] = val;
        return Array(self.cache);
    end;

    pop = function(self, i)
        local v, new = pop(self, i);
        self = new;
        return v;
    end;
    
    table = function(self)
        return self.cache;
    end,

    tuple = function(self)
        return self:unpack();
    end
}

return Array;