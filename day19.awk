#!/usr/bin/awk -f
/=>/ {
  counts[$1]++
  transforms[$1 SUBSEP counts[$1]] = $3
}
END {
  if(part == 1) {
    for(key in transforms) {
      split(key, keys, SUBSEP)
      print replace_all(keys[1], transforms[key])
    }
  } else if (part == 2) {
    open_set[$0] = 0
    while(!result) result = astar()
    print result
  }
}

function replace_all(from, to,  replacements) {
  pre = ""
  post = $0
  i = index(post, from)
  stretch = length(from)
  while(index(post, from)) {
    post_replaced = post
    sub(from, to, post_replaced)
    replacements = replacements "\n" pre post_replaced
    i = index(post, from)
    pre = pre substr(post, 0, i + stretch)
    post = substr(post, i + stretch)
  }
  return replacements
}

function astar() {
  cheapest = ""
  cheapest_cost = 1000

  for(dest in open_set) {
    cost = length(dest) - open_set[dest]
    if(cost >= cheapest_cost) continue
    cheapest = dest
    cheapest_cost = cost
  }

  if(!cheapest) return "failed"
  $0 = cheapest
  steps = open_set[$0]
  delete open_set[$0]
  closed_set[$0] = steps
  steps = steps + 1

  for(key in transforms) {
    split(key, keys, SUBSEP)
    replacements = replace_all(transforms[key], keys[1])
    split(replacements, neighbours, /\s+/)
    for(i in neighbours) {
      n = neighbours[i]
      if(!n) continue
      if(n == "e") return steps
      if(n in closed_set) continue
      if(n in open_set) continue
      open_set[n] = steps
    }
  }
}
