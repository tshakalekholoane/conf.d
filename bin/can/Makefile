COMMIT = $(shell git rev-parse --short HEAD)
DATE   = $(shell date -u +"%Y.%m.%d")
BUILD  = $(shell printf "%s (%s)" "$(DATE)" "$(COMMIT)" )
CC     = clang
CFLAGS = -DCAN_BUILD="\"$(BUILD)\"" -O3 -Wall -Weverything -Wextra \
	-Wno-c++98-compat -Wno-cast-function-type-strict \
	-Wno-declaration-after-statement -Wno-format-nonliteral \
	-Wno-incompatible-pointer-types-discards-qualifiers \
	-Wno-poison-system-directories -Wno-vla -framework Foundation -march=native \
	-pedantic -std=c17

.PHONY: all clean

all:
	$(CC) $(CFLAGS) -o ../can.exe main.c

clean:
	rm -f ../can.exe
