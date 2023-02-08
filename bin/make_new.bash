#!/usr/bin/env bash
# Generates a Makefile.

cat > Makefile << _EOF_
## help: print this help message
.PHONY: help
help:
	@echo 'Usage:'
	@sed -n 's/^##//p' \${MAKEFILE_LIST} | column -t -s ':' | sed -e 's/^/ /'
_EOF_
