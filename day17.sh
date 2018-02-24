#!/usr/bin/env bash
echo -n "Part 1: "
cat input17.txt | ./day17.awk | wc -l
echo -n "Part 2: "
cat input17.txt | ./day17.awk | awk '{print NF}' | sort -n | uniq -c | head -n1
