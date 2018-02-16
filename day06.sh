#!/usr/bin/env bash

cat input06.txt \
  | sed -e 's/turn //' -e 's/,/ /g' -e 's/through //' \
  | ./day06.awk -v part=1 \
  | ./grid.bc \
  | (
    read answer
    echo "Part 1: $answer"
  ) & \
cat input06.txt \
  | sed -e 's/turn //' -e 's/,/ /g' -e 's/through //' \
  | ./day06.awk -v part=2 \
  | ./grid.bc \
  | (
    read answer
    wait
    echo "Part 2: $answer"
  )
