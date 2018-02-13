#!/usr/bin/awk -f
BEGIN {
  print "width = 1000;"
  print "height = 1000;"
}
part == 1 {
  if($1 == "toggle") {
    printf "a = toggle(%d, %d, %d, %d)\n", $2, $3, $4, $5
  } else {
    if($1 == "on") val = 1
    else val = 0
    printf "a = set(%d, %d, %d, %d, %d)\n", $2, $3, $4, $5, val
  }
}
part == 2 {
  if($1 == "toggle") {
    val = 2
  } else if ($1 == "on") {
    val = 1
  } else {
    val = -1
  }
  printf "a = add(%d, %d, %d, %d, %d)\n", $2, $3, $4, $5, val
}
END {
  print "print sum()"
}
