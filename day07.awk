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
  print "print lx"
}

function depend(var, dep, i) {
  if(dep ~ "[0-9]+" || (dep in resolved)) return 1
  dependencies[var][dep] = 1
  notify[dep][var] = 1
}

function is_resolved(var) {
  if(!(var in dependencies)) return 1
  for(dep in dependencies[var]) {
    if(!(dep in resolved)) {
      return 0
    }
  }
  return 1
}

function resolve(dep) {
  resolved[dep] = 1
  if(!(dep in notify)) return
  for(var in notify) {
    if(is_resolved(var) && (var in pending) && (pending[var] != 0)) {
      print pending[var]
      pending[var] = 0
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
