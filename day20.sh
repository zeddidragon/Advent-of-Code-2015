#!/usr/bin/env bash
target=$(cat input20.txt)
j=$(expr $target / 50)
j=$(echo "j=$j;factor=10;target=$target;run()" | ./day20.bc)
echo "Part 1: $j"
echo -n "Part 2: "
echo "j=$j;factor=11;target=$target;limit=50;run()" | ./day20.bc
