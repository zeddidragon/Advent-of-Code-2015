#!/usr/bin/awk -f
{
  len = length($0)
  split($0, row, "")
  for(i = 1; i <= len; ++i) {
    if(row[i] == "#") val = 1
    else val = 0
    printf "grid[%i] = %i\n", (NR - 1) * 100 + (i - 1), val
  }
}
END {
  print "width = " len
  print "height = " NR
  print "run(100)"
}
