#!/usr/bin/env bash
cat <(
  echo "Part 1: "
  cat input24.txt | ./day24.awk -v div=3 | sort -nk 2 -nk 3 | head -n 1
) <(
  echo "Part 2: "
  cat input24.txt | ./day24.awk -v div=4 | sort -nk 2 -nk 3 | head -n 1
)
