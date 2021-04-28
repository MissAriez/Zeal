local base64 = require 'base64class'

return Command 'base64'
    :setCategory 'Utility'
    :setDesc 'Encodes/decodes a message in base64.'
    :setAliases {'b64'}
    :setUsage  '<encode/decode> <message>'
    :run(function(msg, args, util)
        local option = args:first():lower()
        local message = args:shift():join ' '
        
        if option == 'encode' then
            message = base64:encode(message)
        elseif option == 'decode' then
            message = base64:decode(message)
        else
            return msg:reply 'Invalid option. Must be "encode" or "decode"'
        end

        msg.channel:send(message)
    end);