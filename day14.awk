#!/usr/bin/awk -f
{
  speeds[$1] = $4
  airtimes[$1] = $7
  resttimes[$1] = $14
  points[$1] = 0
}
END {
  for(i = 0; i < time; ++i) {
    for(deer in speeds) {
      phase = i % (airtimes[deer] + resttimes[deer])
      if(phase < airtimes[deer]) distances[deer] += speeds[deer]
      if(distances[deer] > max) max = distances[deer]
    }

    for(deer in speeds) if(distances[deer] == max) ++points[deer]
  }

  for(deer in speeds) print deer, distances[deer] "km", points[deer] "pts"
}
