log_prefix=""

log::set_prefix() {
  log_prefix="$1"
}

log::errorf() {
  printf "${log_prefix}$*" >& 2
}

log::fatalf() {
  log::errorf "$*"
  exit 1
}
