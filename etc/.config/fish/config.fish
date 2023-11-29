abbr --add --global a "x_update_appearance"
abbr --add --global c "chmod +x"
abbr --add --global f "x_fmt"
abbr --add --global less "less -FIRX"
abbr --add --global licence "x_licence"
abbr --add --global ll "ls -lhAF"
abbr --add --global ls "ls -F"
abbr --add --global m "x_md"
abbr --add --global t "x_tape_archive"
abbr --add --global v "nvim"
abbr --add --global vf "nvim (fzf)"

set --export dl ~/Downloads
set --export dsk ~/Desktop
set --export x ~/x

set --export CLICOLOR 1
set --export EDITOR (which nvim)
set --export FZF_DEFAULT_COMMAND "fd --type file --follow --hidden --exclude .git"
set --export FZF_DEFAULT_OPTS "\
--color=bg+:#414559,bg:#303446,spinner:#f2d5cf,hl:#e78284 \
--color=fg:#c6d0f5,header:#e78284,info:#ca9ee6,pointer:#f2d5cf \
--color=marker:#f2d5cf,fg+:#c6d0f5,prompt:#ca9ee6,hl+:#e78284"
set --export GNUPGHOME ~/.config/gnupg
set --export GPG_TTY (tty)

if test (uname -m) = "arm64"
  eval (/opt/homebrew/bin/brew shellenv)
end
fish_add_path --global ~/.cargo/bin ~/bin ~/go/bin

fish_hybrid_key_bindings
set fish_cursor_default block
set fish_cursor_insert line
set fish_cursor_replace_one underscore
function fish_mode_prompt; end

# Remap keys if the USB keyboard is not connected (it is harder to pick 
# out the Bluetooth keyboard).
if not ioreg -p IOUSB | rg "USB Keyboard" &> /dev/null
  darwin_remap 1> /dev/null
end

gpgconf --launch gpg-agent
umask 0002
