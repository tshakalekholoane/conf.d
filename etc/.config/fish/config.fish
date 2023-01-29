abbr --add --global c "x_cheat"
abbr --add --global ipython "python3 -m IPython"
abbr --add --global less "less -FIRX"
abbr --add --global ll "ls -lhAF"
abbr --add --global ls "ls -F"
abbr --add --global md "x_md"

set --export conf "$HOME/conf.d"
set --export dl "$HOME/Downloads"
set --export dsk "$HOME/Desktop"
set --export x "$HOME/x"

set --export CLICOLOR 1

# By default, all variables that end in "PATH" (case-sensitive) become
# PATH variables in Fish.
set --export XBINPATH "$HOME/bin"
set --export XGOPATH /usr/local/go/bin
set --export XGOBINPATH "$HOME/go/bin"
set --export XRUSTPATH "$HOME/.cargo/bin"

set --export cc (basename (fd -1 '^gcc-\d+$' /usr/local/bin/))
set --export cdflags "-Og -Wall -Wextra -g3 -pedantic -std=c2x -fsanitize=address"
set --export crflags "-O3 -Wall -Wextra -pedantic -std=c2x"

set --export GNUPGHOME "$HOME/.config/gnupg"
set --export GPG_TTY (tty)

fish_hybrid_key_bindings
set fish_cursor_default block
set fish_cursor_insert line
set fish_cursor_replace_one underscore


# Remap keys if the USB keyboard is not connected (it is harder to pick out the
# Bluetooth keyboard).
if not ioreg -p IOUSB | rg "USB Keyboard" &> /dev/null
  darwin_remap
end

gpgconf --launch gpg-agent
umask 0002
