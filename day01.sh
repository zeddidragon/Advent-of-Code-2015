#!/usr/bin/env bash
cat input01.txt | grep -o . | awk -f day01.awk
