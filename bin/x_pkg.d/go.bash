LATEST="go1.20.2"

go::setup() {
  git checkout "${LATEST}"
  cd src
  ./all.bash
}

go::install() {
  git clone https://go.googlesource.com/go && cd go
  go::setup
}

go::upgrade() {
  git fetch
  go::setup
}
