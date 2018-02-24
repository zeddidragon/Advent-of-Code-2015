#!/usr/bin/env bash

cat <(
  cat input18.txt \
    | ./day18.awk \
    | ./day18.bc \
    | (
      read answer
      echo "Part 1: $answer"
    )
) <(
  cat <(echo "corners = 1") <(cat input18.txt | ./day18.awk) \
    | ./day18.bc \
    | (
      read answer
      echo "Part 2: $answer"
    )
)
