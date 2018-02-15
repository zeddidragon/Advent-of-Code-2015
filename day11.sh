#!/usr/bin/env bash

patternize() {
  tr -s [:space:] '|' \
    | rev | cut -c 2- \
    | tr -d [:space:]
}

alphabet=$(
  echo {a..z} \
    | grep -o [a-z] \
    | grep -ve i -e o -e l \
    | tr -d [:space:]
)

straights=$(
  yes $(echo -n {z..a} | tr -d [:space:]) \
    | awk '{print substr($1, NR, 3)} NR == 24 {exit}' \
    | grep -ve i -e o -e l \
    | patternize
)

pairs=$(
  echo {z..a} \
    | grep -o [a-z] \
    | awk '{print $1 $1}' \
    | patternize
)
pairs="($pairs).*($pairs)"
pass=$(cat input11.txt)

args() {
  echo -n " -v alphabet=$alphabet"
  echo -n " -v pass=$pass"
  echo -n " -v straights=$straights"
  echo -n " -v pairs=$pairs"
  echo -n " -v parts=2"
}

yes | ./day11.awk $(args)
