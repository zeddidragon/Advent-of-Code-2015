#!/usr/bin/env bash

echo -n "Part 1: "
cat input19.txt | ./day19.awk -v part=1 | sort | uniq | wc -l
echo -n "Part 2: "
cat input19.txt | ./day19.awk -v part=2
