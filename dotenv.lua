local Array = require 'Array';

local function parse_env(src)
    local KV = src:split('\n');
    local env = {};
    for _, kv in pairs(KV) do
        local pair = kv:split('=');
        local k, v = table.unpack(pair);
        env[k] = v;
    end
    return env;
end

local env = io.open('./.env', "r+");
if env then
    getfenv(0).env = parse_env(env:read('*a'));
else
    error 'No .env file found.';
end