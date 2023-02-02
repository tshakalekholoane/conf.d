abbr --add --global c "x_cheat"
abbr --add --global ipython "python3 -m IPython"
abbr --add --global less "less -FIRX"
abbr --add --global ll "ls -lhAF"
abbr --add --global ls "ls -F"
abbr --add --global md "x_md"
abbr --add --global pkg "x_pkg"

set --export conf "$HOME/conf.d"
set --export dl "$HOME/Downloads"
set --export dsk "$HOME/Desktop"
set --export x "$HOME/x"

set --export CLICOLOR 1

set --export cc (basename (fd -1 '^gcc-\d+$' /usr/local/bin/))
set --export cdflags -std=c2x -Og -g3 -Wall -Wextra -pedantic -fsanitize=address -fno-omit-frame-pointer
set --export crflags -std=c2x -O3 -Wall -Wextra -pedantic

set --export GNUPGHOME "$HOME/.config/gnupg"
set --export GPG_TTY (tty)

fish_add_path --global ~/bin /usr/local/go/bin ~/go/bin ~/.cargo/bin

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
umask 0002
