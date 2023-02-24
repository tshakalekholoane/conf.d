abbr --add --global a "x_update_appearance"
abbr --add --global c "x_cheat"
abbr --add --global less "less -FIRX"
abbr --add --global ll "ls -lhAF"
abbr --add --global ls "ls -F"
abbr --add --global md "x_md"
abbr --add --global pkg "x_pkg"
abbr --add --global v "nvim_run"
abbr --add --global vf "nvim_run (fzf)"

set --export conf ~/conf.d
set --export dl ~/Downloads
set --export dsk ~/Desktop
set --export x ~/x

set --export cc (basename (fd -1 '^gcc-\d+$' /usr/local/bin/))
set --export cdflags -std=c2x -Og -g3 -Wall -Wextra -pedantic -fsanitize=address -fno-omit-frame-pointer
set --export crflags -std=c2x -O3 -Wall -Wextra -pedantic

set --export CLICOLOR 1
set --export FZF_DEFAULT_COMMAND "fd --type file --follow --hidden --exclude .git"
set --export GNUPGHOME ~/.config/gnupg
set --export GPG_TTY (tty)

fish_add_path --global ~/.cargo/bin ~/bin ~/go/bin

# XXX: On Linux.
# fish_add_path /usr/local/go/bin 

fish_hybrid_key_bindings
set fish_cursor_default block
set fish_cursor_insert line
set fish_cursor_replace_one underscore


# Remap keys if the USB keyboard is not connected (it is harder to pick out the
# Bluetooth keyboard).
if not ioreg -p IOUSB | rg "USB Keyboard" &> /dev/null
  darwin_remap 1> /dev/null
end

gpgconf --launch gpg-agent
nohup colourd >> ~/var/log/colourd.log &
umask 0002
