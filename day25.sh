#!/usr/bin/env bash
cat input25.txt | grep -Eo '[0-9]+' | (
  echo "Final part: "
  echo "code($(paste -sd "," -))" | ./day25.bc
)
