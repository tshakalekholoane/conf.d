function fish_mode_prompt --description "Custom vi mode prompt."
  # See the following for reference 
  # https://github.com/fish-shell/fish-shell/blob/master/share/functions/fish_default_mode_prompt.fish.
  switch $fish_bind_mode
  case default
    set_color --bold red
    echo "NOR"
  case insert
    set_color --bold green
    echo "INS"
  case replace_one 
    set_color --bold green
    echo "REP"
  case replace
    set_color --bold cyan
    echo "REP"
  case visual
    set_color --bold magenta
    echo "VIS"
  end
  set_color normal
  echo -n " "
end
