local class = require 'class'
return class {
    constructor = function(self, name)
        self.name = name
        self.usage = '<none>'
        self.aliases = Array()
    end;
    setCategory = function(self, category)
        self.category = category
        return self
    end;
    setDesc = function(self, desc)
        self.desc = desc
        return self
    end;
    setAliases = function(self, aliases)
        self.aliases = Array(aliases)
        return self
    end;
    setUsage = function(self, usage)
        self.usage = usage
        return self
    end;
    setPerms = function(self,perms)
        self.perms = perms
        return self
    end;
    optionalArgs = function(self)
        self.optionalargs = true
        return self
    end;
    run = function(self, run_fn)
        self.run = run_fn
        return self
    end;
}