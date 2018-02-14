#!/usr/bin/awk -f
{
  cities[$1] = 1
  cities[$3] = 1
  links[$1, $3] = $5
}
END {
  for(start in cities) {
    travel(0, start, start)
  }
}

function travel(dist, from, traveled,   to,   n) {
  n = 0
  for(key in links) {
    split(key, keys, SUBSEP)
    if(from == keys[1]) to = keys[2]
    else if(from == keys[2]) to = keys[1]
    else continue
    if(traveled ~ to) continue
    n++

    travel(dist + links[key], to, traveled " - " to)
  }
  if(!n) {
    print dist, traveled
  }
}
