return function(cases)
    for condition, callback in pairs(cases) do
        if condition then
            return callback();
        end
    end
end