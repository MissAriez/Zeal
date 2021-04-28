local mt = {};
mt.__index = mt;

return function(name)
    local function createClass(n, options)
        assert(options.constructor, 'a constructor is needed to create a class!');

        local class_mt = {
            __name = n;
            __id = math.random(0x10000000000);
        }

        function class_mt.__tostring()
            return 'Class "'..class_mt.__name..'": '..class_mt.__id
        end
        
        local constructor;
        constructor = function(...)
            local instance = {
                __mt = class_mt;
                __index = class_mt;
            };

            for name, method in pairs(options) do
                if name == 'extends' then
                    local extension;
                    if type(method) == 'table' then
                        if getmetatable(method) and getmetatable(method).__call then
                            extension = method(...);
                        else
                            extension = method;
                        end
                    elseif type(method) == 'function' then
                        extension = method(...);
                    else
                        error 'class extension needs to be another class or an object.'
                    end

                    for nm, mthd in pairs(extension) do
                        instance[nm] = mthd;
                    end
                elseif (name ~= 'constructor' and instance[name] == nil and name ~= 'extends') and type(method) == 'function' or type(method) == 'thread' then
                    instance[name] = method;
                end
            end

            options.constructor(instance, ...);

            setmetatable(instance, instance.__mt);
            return instance;
        end

        setmetatable(class_mt, {
            __call = function(self, ...)
                return constructor(...);
            end
        });

        return class_mt;
    end

    if type(name) == 'table' then
        return createClass('unknown', name);
    end

    return function(options)
        return createClass(name, options);
    end
end