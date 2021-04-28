local fs = require 'fs'
local read_dir = fs.readdirSync

local cmddir = './cmds';
local commands = table.filter(read_dir(cmddir), function(f)
    return f:endsWith('.lua');
end)

local categories = {};

for _, file in pairs(commands) do
    local pull = require(cmddir..'/'..file);
    if pull.name then
        if not categories[pull.category] then
            categories[pull.category] = {};
        end

        local category = categories[pull.category];
        category[#category + 1] = pull;
        for catname, cmds in pairs(categories) do
            client._categories:set(catname:lower(), cmds);
        end

        client._commands:set(pull.name, pull);
        if pull.aliases then
            for _, alias in pairs(pull.aliases) do
                client._aliases:set(alias, pull.name);
            end
        end
    end
end
