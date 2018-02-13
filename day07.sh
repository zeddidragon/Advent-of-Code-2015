#!/usr/bin/env bash
cat input07.txt \
  | sed -e 's/\bif\b/biff/' -e ''\
  | tr A-Z a-z \
  | ./day07.awk \
  | ./bitwise.bc
