function fish_prompt -d "Writes prompt."
    echo "% "
end

function fish_right_prompt -d "Writes right prompt."
    if git rev-parse --is-inside-work-tree &>/dev/null && test (git rev-parse --is-bare-repository) = false
        if test (git status --porcelain | wc -l | sed 's/^[[:space:]]*//') != 0
            set is_dirty "+"
        end
        echo (set_color brred)"$is_dirty"(set_color normal)(git branch --show-current)
    end
end
