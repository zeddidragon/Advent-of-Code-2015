#!/usr/bin/env bash
yes $(cat input04.txt) | awk '{}{print $1 NR}' | ./md5 | ./day04.awk
