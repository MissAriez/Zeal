return Command 'pin'
    :setCategory 'Admin'
    :setDesc 'Pins messgae in the channel, or the message provided by ID in the channel executed in if no ID is provided.'
    :setAliases {'keep'}
    :setPerms 'admin'
    :setUsage '<messageId>'
    :optionalArgs()
    :run(function(msg, args, util)

        local message;
        if args:length() < 1 then
            message = msg.channel:getMessages(2):toArray()[2];
        else
            message = msg.channel:getMessages(args:first());
        end

            message:pin();

            msg:reply(('Succesfully pinned message `%s`.'):format(message.id));
    end)