#!/usr/bin/awk -f
{
  values[NR] = $0
}
END {
  count = 0
  for(i in values) {
    sum += values[i]
    count++
  }
  slice = sum / div

  for(i in values) {
    permute("|", i, 0)
  }
}

function permute(path, ind, sum,   j, k, new_sum, value, new_path) {
  for(j = ind; j <= count; j++) {
    value = values[j]
    if(!value) continue

    new_sum = sum + value
    if(new_sum > slice) return
    new_path = path value "|"
    if(new_sum == slice) return print_path(new_path)

    permute(new_path, j + 1, new_sum)
  }
}

function print_path(path,   i, count, quantum, sum) {
  split(path, vals, "|")
  quantum = 1
  count = 0
  sum = 0
  for(i in vals) {
    val = vals[i]
    if(!val) continue
    count++
    sum += val
    quantum *= val
  }
  if(count == 0) return
  printf sum "\t" count "\t" quantum "\t"
  for(i in vals) {
    if(!vals[i]) continue
    printf " " vals[i]
  }
  print ""
}
