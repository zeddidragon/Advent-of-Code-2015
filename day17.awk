#!/usr/bin/awk -f
BEGIN {
  if(!volume) volume = 150
}
{
  n++
  containers[n] = $1
}
END {
  list(1, 0, "")
}

function list(start, sum, combination,  i) {
  for(i = start; i <= n; ++i) {
    if(sum + containers[i] == volume) {
      print combination " " containers[i]
    } else {
      list(i + 1, sum + containers[i], combination " " containers[i])
    }
  }
}
