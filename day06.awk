BEGIN {
  print "yes \|\\"
  print "awk '{printf \"%1000s\\n\", \"\"} NR == 1000 {exit}' \|\\"
  print "awk '{gsub(/ /, \"x\"); print}' \|\\"
}
{
  header = sprintf("NR > %i && NR <= %i", $3, $5 + 1)
  left = sprintf("left = substr($1, 0, %i)", $2)
  right = sprintf("right = substr($1, %i)", $4 + 1)
  if($1 == "on") {
    body = \
      sprintf("body = sprintf(\"%%%is\", \"\");", $4 - $2) \
      "gsub(/ /, \"O\", body)"
  } else if($1 == "off") {
    body = \
      sprintf("body = sprintf(\"%%%is\", \"\");", $4 - $2) \
      "gsub(/ /, \"x\", body)"
  } else {
    body = \
      sprintf("body = substr($1, %i, %i);", $2 + 1, $4 - $2) \
      "gsub(/x/, \"X\", body);" \
      "gsub(/O/, \"x\", body);" \
      "gsub(/X/, \"O\", body)"
  }
  
  printf "awk '%s {%s; %s; %s; $1 = left body right;}{print}'\|\\\n", header, left, right, body
}
END {
  print "grep -o O | wc -l"
}
