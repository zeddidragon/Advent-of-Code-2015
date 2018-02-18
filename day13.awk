#!/usr/bin/awk -f
{
  sub(/\./, "", $11)
  people[$1] = 1
  people[$11] = 1
  if($3 == "gain") {
    happiness[$1, $11] = +$4
  } else {
    happiness[$1, $11] = -$4
  }
}
END {
  for(person in people) count++
  seat() }

function seat(seated,   n, person) {
  for(person in people) {
    if(seated ~ person) continue
    n++
    seat(seated " " person)
  }

  if(!n) {
    sum = 0
    split(seated, seated_arr, " ")
    for(i in seated_arr) {
      if(i == skip) continue
      person = seated_arr[i]
      if(i == 1) left = seated_arr[count]
      else       left = seated_arr[i - 1]
      sum += happiness[person, left]
      sum += happiness[left, person]
    }

    print sum, insert seated
  }
}
