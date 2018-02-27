#!/usr/bin/env bash

echo -n "Part 1: "
./day19.awk < input19.txt | sort | uniq | wc -l
