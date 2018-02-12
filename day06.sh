#!/usr/bin/env bash
bash <(
  cat input06.txt \
    | sed -e 's/turn //' -e 's/,/ /g' -e 's/through //' \
    | awk -f day06.awk
)
