set --local kernel (uname)
set --local machine (uname -m)

if test $kernel = "Linux"
  abbr --add --global can "gio trash"
end
abbr --add --global f "x_fmt"
abbr --add --global less "less -FIRX"
abbr --add --global licence "x_licence"
abbr --add --global ll "ls -lhAF"
abbr --add --global ls "ls -F"
abbr --add --global m "x_md"
abbr --add --global p "python3"
abbr --add --global v "nvim"
abbr --add --global vf "nvim (fzf --scheme path)"

set --export dl ~/Downloads
set --export dsk ~/Desktop
set --export x ~/x

set --export CLICOLOR 1
set --export EDITOR (which nvim)
set --export FZF_DEFAULT_COMMAND "fd --type file --follow --hidden --exclude .git"
set --export GNUPGHOME ~/.config/gnupg
set --export GPG_TTY (tty)

if test $kernel = "Darwin" -a $machine = "arm64"
  fish_add_path --global /opt/homebrew/bin /opt/homebrew/sbin
end
fish_add_path --global ~/.cargo/bin ~/bin ~/go/bin

fish_hybrid_key_bindings
set fish_cursor_default block
set fish_cursor_insert line
set fish_cursor_replace_one underscore
function fish_mode_prompt; end

gpgconf --launch gpg-agent
umask 0002
