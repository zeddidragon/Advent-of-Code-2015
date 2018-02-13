#!/usr/bin/awk -f

{
  if($2 == "->") {
    line = sprintf("%s = %s", $3, $1)
    register($3, line, $1, 0)
  } else if($1 == "not") {
    line = sprintf("%s = bitnot(%s)", $4, $2)
    register($4, line, $2, 0)
  } else {
    line = sprintf("%s = bit%s(%s, %s)", $5, $2, $1, $3)
    register($5, line, $1, $3)
  }
}
END {
  print "print a"
}

function depend(var, dep, i) {
  if(dep ~ "[0-9]+" || (dep in resolved)) return 1
  dependencies[var, dep] = 1
  notify[dep, var] = 1
}

function is_resolved(var) {
  for(key in dependencies) {
    split(key, keys, SUBSEP)
    if(keys[1] != var) continue
    if(!(keys[2] in resolved)) return 0
  }
  return 1
}

function resolve(dep) {
  resolved[dep] = 1
  for(key in notify) {
    split(key, keys, SUBSEP)
    if(keys[1] != dep) continue
    var = keys[2]
    if((var in pending) && is_resolved(var)) {
      print pending[var]
      delete pending[var]
      resolve(var)
    }
  }
}

function register(var, line, dep1, dep2) {
  depend(var, dep1, 1)
  depend(var, dep2, 2)

  if(is_resolved(var)) {
    print line
    resolve(var)
  } else {
    pending[var] = line
  }
}
