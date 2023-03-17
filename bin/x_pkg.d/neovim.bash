PROG="$(basename "$0")"
HOMEBREW="$(which brew)"

neovim::setup() {
  if [[ ! -e "${HOMEBREW}" ]]; then
    printf "%s: package manager not found\n" "${PROG}" >&2
    exit 1
  fi
  brew install ninja libtool cmake pkg-config gettext curl
  make CMAKE_BUILD_TYPE=RelWithDebInfo
  sudo make install
}

neovim::install() {
  git clone https://github.com/neovim/neovim && cd neovim 
  neovim::setup
}

neovim::upgrade() {
	git pull
	neovim::setup
}
