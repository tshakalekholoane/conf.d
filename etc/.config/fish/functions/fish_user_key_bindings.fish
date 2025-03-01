function fish_user_key_bindings
    for mode in (bind --list-modes)
        bind --mode $mode ctrl-c cancel-commandline
    end
end
