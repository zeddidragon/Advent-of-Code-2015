#!/usr/bin/env bash
sum() {
 grep -oE "\-?[0-9]+$" | awk '{sum += $1} END{print sum}'
}

echo -n "Part 1: "
cat input12.json | ./json.awk | sum
blacklist=$(
  cat input12.json \
    | ./json.awk \
    | grep -E "\"red\"$" \
    | grep -o "\[.*\"\]" \
    | grep -oE "(\"?([a-z0-9])+\"?,)+" \
    | sort \
    | uniq \
    | sed -e "s/^/-e '\\\[/" -e "s/$/'/" \
    | paste -sd " " -
)

echo -n "Part 2: "
cmd="grep -v $blacklist"
cat input12.json \
  | ./json.awk \
  | eval $cmd \
  | sum
