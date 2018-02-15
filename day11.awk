#!/usr/bin/awk -f
BEGIN {
  part = 1
  split(alphabet, arr_alpha, "")
  for(i in arr_alpha) {
    map_alpha[arr_alpha[i]] = i
  }
}
{
  pass = mutate(pass)
  if(valid(pass)) {
    printf "Part %i: %s\n", part, pass
    if(++part > parts) exit
  }
}

function valid(str) {
  return str ~ straights && str !~ /[iol]/ && str ~ pairs
}

function mutate(str,  char, head) {
  len = length(str)
  head = substr(str, 1, len - 1)
  char = substr(str, len, 1)
  if(char == "z") {
    return mutate(head) "a"
  } else {
    return head arr_alpha[map_alpha[char] + 1]
  }
}
