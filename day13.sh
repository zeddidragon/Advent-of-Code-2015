#!/usr/bin/env bash
cat <(
  cat input13.txt \
    | ./day13.awk \
    | sort -nr \
    | ( echo "Part 1: $(head -n 1)" )
) <(
  cat input13.txt \
    | ./day13.awk -v skip=1 insert=Zeddy \
    | sort -nr \
    | ( echo "Part 2: $(head -n 1)" )
)
