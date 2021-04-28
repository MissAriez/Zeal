local flatdb = require './flatdb'
local class = require './class'

return class {
    constructor = function(self, dir)
        self.db = flatdb(dir)
        if not self.db.page then
            self.db.page = {}
        end
    end;
    page = function(self)
        return self.db.page
    end;
    get = function(self, key)
        if not key then return warn 'No key to get. (quick.db)' end
        return self:page()[key]
    end;
    set = function(self, key, value)
        if not key then return warn 'No key to set. (quick.db)' end
        if not value then return warn 'No value to set to. (quick.db)' end
        self:page()[key] = value
        self.db:save()
    end;
}