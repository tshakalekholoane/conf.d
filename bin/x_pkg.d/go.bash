DEFAULT_TAG="go1.20"

go::setup() {
  git checkout $DEFAULT_TAG
	cd src
	./all.bash

	# XXX: Additional setup is required on Linux to remove (and create) 
	# /usr/local/go/bin.

	sudo cp -f ../bin/* /usr/local/bin/
}

go::install() {
  git clone https://go.googlesource.com/go && cd go
	go::setup 
}

go::upgrade() {
  git fetch
	go::setup
}
