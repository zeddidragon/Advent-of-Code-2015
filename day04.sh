#!/usr/bin/env bash

seed=$(cat input04.txt)
yes | awk -v seed=$seed '{}{print seed NR}' | ./md5.js | awk -f day04.awk
