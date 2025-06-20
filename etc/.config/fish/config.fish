set --local kernel (string lower (uname))

if test $kernel = linux
    abbr --add --global can "gio trash"
end
abbr --add --global f format
abbr --add --global less "less -FIRX"
abbr --add --global ll "ls -lhAF"
abbr --add --global ls "ls -F"
abbr --add --global m mkdir_and_cd
abbr --add --global p python3
abbr --add --global t tiny
abbr --add --global v nvim
abbr --add --global vf "nvim (fzf --scheme path)"

if test $kernel = darwin
    set --export EDITOR /opt/homebrew/bin/nvim
    set --export GOARM64 v8.5,lse,crypto
end
set --export CLICOLOR 1
set --export FZF_DEFAULT_COMMAND "fd --type file --follow --hidden --exclude .git"
set --export GNUPGHOME ~/.config/gnupg
set --export GPG_TTY (tty)
set --export dl ~/Downloads
set --export dsk ~/Desktop
set --export x ~/x

if test $kernel = darwin
    fish_add_path --global /opt/homebrew/bin /opt/homebrew/sbin
end
fish_add_path --global ~/.cargo/bin ~/bin ~/go/bin

fish_hybrid_key_bindings

gpgconf --launch gpg-agent
umask 0002
