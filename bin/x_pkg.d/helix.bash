helix::setup() {
	cargo install --locked --path helix-term
	ln -sf $PWD/runtime $HOME/.config/helix/runtime
	hx --grammar fetch && hx --grammar build
}

helix::install() {
	git clone https://github.com/helix-editor/helix && cd helix
	helix::setup
}

helix::upgrade() {
	git pull
	helix::setup
}
