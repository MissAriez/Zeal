return Command 'unpin'
    :setCategory 'Admin'
    :setDesc 'Unpins messgae in the channel executed in.'
    :setAliases {'unkeep'}
    :setPerms 'admin'
    :setUsage '<messageId>'
    :run(function(msg, args, util)

    local message;
    if args:length() < 1 then
        message = msg.channel:getMessages(2):toArray()[2];
    else
        message = msg.channel:getMessage(args:first());
    end

        message:unpin();

        msg:reply(('Succesfully unpinned message `%s`.'):format(message.id));
end)