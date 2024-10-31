BUILD := $(shell printf "%s (%s)" $(shell date -u +"%Y.%m.%d") $(shell git log -n 1 --pretty=format:"%H" | head --bytes 7))
CC := clang
CFLAGS := -DBUILD="\"$(BUILD)\"" -O3 -Wall -Weverything -Wextra \
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
