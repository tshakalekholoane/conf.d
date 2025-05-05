function mkdir_and_cd --description "Creates a directory and changes into it."
    mkdir -p "$argv[1]" && cd "$argv[1]"
end
