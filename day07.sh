#!/usr/bin/env bash
assemble() {
  tr A-Z a-z \
    | sed -e 's/[[:<:]]if[[:>:]]/biff/' -e ''\
    | ./day07.awk \
    | ./bitwise.bc
}

a=$(cat input07.txt | assemble)
echo "Part 1: $a"
b=$(cat input07.txt | sed -E "s/[0-9]+ -> b\$/$a -> b/" | tee day07.bc | assemble)
echo "Part 2: $b"
