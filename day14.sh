#!/usr/bin/env bash
final=$(cat input14.txt | ./day14.awk time=2503 | sort -nrk2 | head -n1)
echo "Part 1: $final"

point=$(cat input14.txt | ./day14.awk time=2503 | sort -nrk3 | head -n1)
echo "Part 2: $point"
