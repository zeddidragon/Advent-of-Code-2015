#!/usr/bin/env bash
cat input09.txt \
  | ./day09.awk \
  | sort \
  | (
    echo "Part 1: " $(head -n 1)
    echo "Part 2: " $(tail -n 1)
  )
