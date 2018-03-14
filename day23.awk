#!/usr/bin/awk -f
{
  instructions[NR] = $1
  sub(/,/, "", $2)
  if($1 == "jmp") offsets[NR] = $2
  else registers[NR] = $2
  if($3) offsets[NR] = $3
  values["a"] = a
}
END {
  i = 1
  while(i > 0 && i <= NR) {
    switch(instructions[i]) {
      case "hlf":
        values[registers[i]] /= 2
        break
      case "tpl":
        values[registers[i]] *= 3
        break
      case "inc":
        values[registers[i]] += 1
        break
      case "jmp":
        i += offsets[i]
        continue
      case "jie":
        if(values[registers[i]] % 2) break
        i += offsets[i]
        continue
      case "jio":
        if(values[registers[i]] != 1) break
        i += offsets[i]
        continue
    }
    i++
  }
  print values["b"]
}
