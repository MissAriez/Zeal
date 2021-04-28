local Command = require 'command-class'
return Command 'version'
    :setDesc 'Returns Zeal\'s version.'
    :setCategory 'Info'
    :setAliases { 'model' }
    :run(function(msg, args)
        msg.channel:send(settings.version)
    end);