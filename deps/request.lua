local json = require 'json';
local http = require 'coro-http';
local Promise = require 'Promise';

return function(options)
    assert(options.url or options.link);
    local head, body = http.request(options.method or 'GET', options.link or options.url, options.headers);

    local parsed;
    if options.parser then
        parsed = options.parser:parse(body);
    else
        parsed = json.parse(body);
    end

    return Promise(function(resolved)
        return parsed;
    end);
end