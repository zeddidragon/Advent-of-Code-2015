#!/usr/bin/awk -f
BEGIN {
  print "{$1 = sprintf(\"%1000s\\n\", \"\")}"
  print "{gsub(/ /, \"x\")}"
}
{
  size = $4 - $2 + 1
  header = sprintf("NR > %i && NR <= %i", $3, $5 + 1)
  left = sprintf("left = substr($1, 1, %i)", $2)
  right = sprintf("right = substr($1, %i)", $4 + 2)
  if($1 == "toggle") {
    body = \
      sprintf("body = substr($1, %i, %i);", $2 + 1, size) \
      "gsub(/x/, \"X\", body);" \
      "gsub(/O/, \"x\", body);" \
      "gsub(/X/, \"O\", body)"
  } else {
    if($1 == "on") char = "O"
    else char = "x"
    body = \
      sprintf("body = sprintf(\"%%%is\", \"\");", size) \
      sprintf("gsub(/ /, \"%s\", body)", char)
  }
  
  printf "%s {%s; %s; %s; $1 = left body right}\n", header, left, right, body
}
END {
  print "{print} NR == 1000 {exit}"
}
