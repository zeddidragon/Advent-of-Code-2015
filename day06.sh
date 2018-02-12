#!/usr/bin/env bash
echo -n "Part 1:"
yes \
  | awk -f <(
    cat input06.txt \
      | sed -e 's/turn //' -e 's/,/ /g' -e 's/through //' \
      | ./day06.awk
  ) \
  | grep -o O \
  | wc -l

echo -n "Part 2:"
yes \
  | awk -f <(
    cat input06.txt \
      | sed -e 's/turn //' -e 's/,/ /g' -e 's/through //' \
      | ./day06-2.awk
  ) \
  | grep -o I \
  | wc -l
