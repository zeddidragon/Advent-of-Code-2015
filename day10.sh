#!/usr/bin/env bash

looksay() {
  echo $1 | grep -o "[0-9]" | uniq -c | tr -d '[:space:]'
}

n=$(cat input10.txt | tr -d '[:space:]')
for i in {1..40}; do
  n=$(looksay $n)
done

echo "Part 1: " ${#n}

for i in {1..10}; do
  n=$(looksay $n)
done

echo "Part 2: " ${#n}
