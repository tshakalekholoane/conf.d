function fish_mode_prompt --description "Custom vi mode prompt."
  # See the following for reference 
  # https://github.com/fish-shell/fish-shell/blob/master/share/functions/fish_default_mode_prompt.fish.
  switch $fish_bind_mode
  case default
    set_color black --background white --bold 
    set mode "NOR"
  case insert
    set_color black --background blue --bold 
    set mode "INS"
  case replace, replace_one 
    set_color black --background magenta --bold 
    set mode "REP"
  case visual
    set_color black --background red --bold 
    set mode "VIS"
  end
  printf " %s " $mode
  set_color normal
end
