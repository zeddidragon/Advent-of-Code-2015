#!/usr/bin/env bash

echo "Part 1: "
cat input21.txt | ./day21.awk -v victory=1 | sort | uniq | sort -n | head -n 1
echo "Part 2: "
cat input21.txt | ./day21.awk -v victory=0 | sort | uniq | sort -n | tail -n 1
