function fish_prompt -d "Writes prompt."
  set dir (basename $PWD)
  if test "$dir" = "$USER"
    set dir (prompt_pwd)
  end
  set user (id -un)
  set host (hostname -s)
  echo " "(set_color brred)(id -un)(set_color normal)"@"(set_color brred)(hostname -s)(set_color normal) $dir (set_color brred)"% "(set_color normal)
end

function fish_right_prompt -d "Writes right prompt."
  if git rev-parse --is-inside-work-tree &> /dev/null
    set bare_repo (git rev-parse --is-bare-repository)
    if test "$bare_repo" = "false"
      set dirty (git status --porcelain | rg --count ^)
      if test "$dirty" != ""
        set indicator ●
      end
    end
    echo (set_color normal) "$indicator git:("(set_color brred)(git branch --show-current)(set_color normal)")"
  end
end
