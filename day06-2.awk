BEGIN {
  print "{$1 = sprintf(\"%1000s\\n\", \"\")}"
  print "{gsub(/ /, \"x\t\")}"
}
{
  header = sprintf("NR > %i && NR <= %i", $3, $5 + 1)
  loop = sprintf("i = %i; i <= %i; i++", $2 + 1, $4 + 1)
  if($1 == "on") {
    body = "sub(//, \"I\", $i)"
  } else if($1 == "toggle") {
    body = "sub(//, \"II\", $i)"
  } else {
    body = "sub(/I/, \"\", $i)"
  }
  
  printf "%s {for(%s){%s}}", header, loop, body
}
END {
  print "{print} NR == 1000 {exit}"
}
