#!/usr/bin/env bash
cat input02.txt | sed -e 's/x/\t/g' | ./day02.awk
