#!/usr/bin/env bash
# Removes trailing whitespace from a text file.

sed -i 's/[[:space:]]*$//' "$1"
