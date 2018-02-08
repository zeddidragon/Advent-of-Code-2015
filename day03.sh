#!/usr/bin/env bash
printf "Part 1: "
cat input03.txt | grep -o . | awk -f day03.awk | sort | uniq | wc -l
printf "Part 2: "
cat \
  <(cat input03.txt | grep -o . | awk 'NR % 2 == 0' | awk -f day03.awk) \
  <(cat input03.txt | grep -o . | awk 'NR % 2 == 1' | awk -f day03.awk) \
  | sort | uniq | wc -l
