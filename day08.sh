#!/usr/bin/env bash
unstripped=$(cat input08.txt | tr -d '[:space:]' | wc -c)
stripped=$(
  cat input08.txt \
    | cut -c 2- | rev | cut -c 2- | rev \
    | sed -e "s/\\\\\"/q/g" \
    | sed -e "s/\\\\\\\\/s/g" \
    | sed -e "s/\\\\x\w\w/1/g" \
    | tr -d '[:space:]' \
    | wc -c
)
echo "Part 1: $(expr $unstripped - $stripped)"
padded=$(
  cat input08.txt \
    | sed -e "s/\\\\/\\\\\\\\/g" \
    | sed -e "s/\"/\\\\\"/g" \
    | sed -e "s/^/\"/" -e "s/$/\"/" \
    | tr -d '[:space:]' \
    | wc -c
)
echo "Part 2: $(expr $padded - $unstripped)"
