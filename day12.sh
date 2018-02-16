#!/usr/bin/env bash
# echo -n "Part 1: "
# cat input12.json | grep -oE "\-?[0-9]+" | awk '{sum += $1} END{print sum}'
cat input12.json | ./json.awk
