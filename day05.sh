#!/usr/bin/env bash
echo -n "Part 1:"
cat input05.txt \
  | grep -E '([aeiou].*){3,}' \
  | grep -E '(\w)\1' \
  | grep -ve 'ab' -e 'cd' -e 'pq' -e 'xy' \
  | wc -l

echo -n "Part 2:"
cat input05.txt \
  | grep -E '(\w\w).*\1' \
  | grep -E '(\w)\w\1' \
  | wc -l
