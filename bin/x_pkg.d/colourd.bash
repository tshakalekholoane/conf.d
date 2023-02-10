colourd::setup() {
	make release
	ln -sf "$PWD/colourd" "$HOME/bin/colourd"
}

colourd::install() {
	git clone https://github.com/tshakalekholoane/colourd && cd colourd
	colourd::setup
}

colourd::upgrade() {
	git pull
	colourd::setup
}
