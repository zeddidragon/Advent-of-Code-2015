#!/usr/bin/awk -f
/=>/ {
  counts[$1]++
  transforms[$1 SUBSEP counts[$1]] = $3
}
END {
  for(key in transforms) {
    split(key, keys, SUBSEP)
    replace_all(keys[1], transforms[key])
  }
}

function replace_all(from, to) {
  pre = ""
  post = $0
  i = index(post, from)
  stretch = length(from)
  while(index(post, from)) {
    post_replaced = post
    sub(from, to, post_replaced)
    print pre post_replaced
    i = index(post, from)
    pre = pre substr(post, 0, i + stretch)
    post = substr(post, i + stretch)
  }
}
