#!/usr/bin/env bash
# Prints a list of used ports.

lsof -i -P -n | rg LISTEN --color="never"
