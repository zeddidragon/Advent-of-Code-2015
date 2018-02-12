#!/usr/bin/awk -f
{
  if($2 == "->") {
    printf "%s = %s\n", $3, $1
  } else if($1 == "NOT") {
    printf "%s = bitnot(%s)\n", $4, $2
  } else if($2 == "LSHIFT") {
    printf "%s = lshift(%s, %s)\n", $5, $1, $3
  } else if($2 == "RSHIFT") {
    printf "%s = rshift(%s, %s)\n", $5, $1, $3
  }
}
