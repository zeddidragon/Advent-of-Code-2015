#!/usr/bin/env bash
exactly() {
  awk "/$2: $1\y/ {print} !/$2/ {print}"
}

fewer() {
  awk "/$3: [0-$(expr $2 - 1)]\y/ {print} !/$3/ {print}"
}

more() {
  awk "/$3: ([$(expr $2 + 1)-9]|[1-9][0-9]+)\y/ {print} !/$3/ {print}"
}

echo "Part 1: "
cat input16.txt \
  | exactly 3 children \
  | exactly 7 cats \
  | exactly 2 samoyeds \
  | exactly 3 pomeranians \
  | exactly 0 akitas \
  | exactly 0 vizslas \
  | exactly 5 goldfish \
  | exactly 3 trees \
  | exactly 2 cars \
  | exactly 1 perfumes

echo "Part 2: "
cat input16.txt \
  | exactly 3 children \
  | more than 7 cats \
  | exactly 2 samoyeds \
  | fewer than 3 pomeranians \
  | exactly 0 akitas \
  | exactly 0 vizslas \
  | fewer than 5 goldfish \
  | more than 3 trees \
  | exactly 2 cars \
  | exactly 1 perfumes
