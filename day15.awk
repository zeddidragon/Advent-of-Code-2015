#!/usr/bin/awk -f
{
  sub(/:/, "", $1)
  portions[$1] = 0
  caps[$1] = $3
  durs[$1] = $5
  flas[$1] = $7
  texs[$1] = $9
  cals[$1] = $11
  count++
}
END {
  # Start with a full mix, equal portions
  if(calories) {
    # Not my proudest moment
    for(ingredient in portions) {
      if(cals[ingredient] == 3) {
        portions[ingredient] = 30
      } else {
        portions[ingredient] = 20
      }
    }
  } else {
    for(ingredient in portions) {
      portions[ingredient] = 100 / count
    }
  }

  # Swap out ingredients if that increases the total
  # If no swaps can increase the total, we're done
  total = calculate()
  improved = 1
  print ""
  while(improved) {
    improved = 0
    for(sub_out in portions) {
      for(sub_in in portions) {
        if(sub_in == sub_out) continue
        portions[sub_out]--
        portions[sub_in]++
        new_total = calculate()
        if(new_total > total && (!calories || cal == calories)) {
          improved = 1
          total = new_total
        } else {
          portions[sub_out]++
          portions[sub_in]--
        }
      }
    }
  }

  print_nutritions()
}

function print_nutritions() {
  total = calculate()
  print title
  for(ingredient in portions) {
    print "\t" portions[ingredient] " tsp " ingredient
  }
  print "Nutritional values:"
  print "\t" cap " kg/h milk absorption"
  print "\t" dur " kN of durability"
  print "\t" fla " MYums flavour"
  print "\t" tex " microCrunch texture"
  print "Cookie value: " total " MNgYumCrunch/s"
  print "Calories: " cal
}

function calculate() {
  cap = 0
  dur = 0
  fla = 0
  tex = 0
  cal = 0
  for(ingredient in portions) {
    n = portions[ingredient]
    cap += caps[ingredient] * n
    dur += durs[ingredient] * n
    fla += flas[ingredient] * n
    tex += texs[ingredient] * n
    cal += cals[ingredient] * n
  }
  return cap * dur * fla * tex
}
