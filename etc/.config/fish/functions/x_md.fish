# XXX: Has to be shell function because a script will execute in a 
# subshell (invalidating the cd command).
function x_md -d "Creates a directory and changes into it."
    mkdir -p "$argv[1]" && cd "$argv[1]"
end
