#!/usr/bin/env bash

cat <(
  echo -n "Part 1: "
  cat input22.txt | ./day22.awk
) <(
  echo -n "Part 2: "
  cat input22.txt | ./day22.awk -v mode=hard
)
