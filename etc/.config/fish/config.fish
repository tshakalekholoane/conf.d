abbr --add --global a "x_update_appearance"
abbr --add --global f "x_fmt"
abbr --add --global less "less -FIRX"
abbr --add --global ll "ls -lhAF"
abbr --add --global ls "ls -F"
abbr --add --global m "x_md"
abbr --add --global p "x_pkg"
abbr --add --global t "x_tape_archive"
abbr --add --global v "nvim_run"
abbr --add --global vf "nvim_run (fzf)"

set --export dl ~/Downloads
set --export dsk ~/Desktop
set --export x ~/x

set --export cc (basename (fd -1 '^gcc-\d+$' /usr/local/bin/))
set --export cdflags -std=gnu2x -Og -g3 -Wall -Wextra -pedantic
set --export crflags -std=gnu2x -O3 -Wall -Wextra -pedantic
set --export csan -fsanitize=address -fno-omit-frame-pointer

set --export CLICOLOR 1
set --export EDITOR (which nvim)
set --export FZF_DEFAULT_COMMAND "fd --type file --follow --hidden --exclude .git"
set --export GNUPGHOME ~/.config/gnupg
set --export GPG_TTY (tty)

fish_add_path --global ~/.cargo/bin ~/bin ~/go/bin ~/src/go/bin

fish_hybrid_key_bindings
set fish_cursor_default block
set fish_cursor_insert line
set fish_cursor_replace_one underscore

# Remap keys if the USB keyboard is not connected (it is harder to pick 
# out the Bluetooth keyboard).
if not ioreg -p IOUSB | rg "USB Keyboard" &> /dev/null
  darwin_remap 1> /dev/null
end

gpgconf --launch gpg-agent
nohup colourd >> ~/var/log/colourd.log &
umask 0002
