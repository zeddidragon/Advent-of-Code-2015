#!/usr/bin/env bash
echo -n "Part 1: "
cat input23.txt | ./day23.awk
echo -n "Part 2: "
cat input23.txt | ./day23.awk -v a=1
