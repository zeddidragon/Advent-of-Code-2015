#!/usr/bin/env bash

seed=$(cat input04.txt)
yes $seed | awk '{}{print $1 NR}' | ./md5 | awk -f day04.awk
