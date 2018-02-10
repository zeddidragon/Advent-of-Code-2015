#!/usr/bin/env bash

seed=$(cat input04.txt)
yes | awk -v seed=$seed '{}{print seed NR}' | ./zcrypt -a md5 | awk -f day04.awk
