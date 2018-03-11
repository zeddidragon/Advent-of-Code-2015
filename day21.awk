#!/usr/bin/awk -f
/Hit Points/ { bhp = $3 }
/Damage/ { batk = $2 }
/Armor/ { bdef = $2 }
END {
  hp = 100

  weapons[4] = 8
  weaponnames[4] = "Dagger"
  weapons[5] = 10
  weaponnames[5] = "Shortsword"
  weapons[6] = 25
  weaponnames[6] = "Warhammer"
  weapons[7] = 40
  weaponnames[7] = "Longsword"
  weapons[8] = 74
  weaponnames[8] = "Greataxe"
  
  armours[1] = 13
  armournames[1] = "Leather"
  armours[2] = 31
  armournames[2] = "Chainmail"
  armours[3] = 53
  armournames[3] = "Splintmail"
  armours[4] = 75
  armournames[4] = "Bandedmail"
  armours[5] = 102
  armournames[5] = "Platemail"

  trinkets[1] = 25
  trinkets[2] = 50
  trinkets[3] = 100
  trinkets[4] = 20
  trinkets[5] = 40
  trinkets[6] = 80

  for(wp = 4; wp <= 8; wp++) {
    for(am = 0; am <= 5; am++) {
      for(tr1 = -1; tr1 <= 6; tr1++) {
        for(tr1 = -1; tr1 <= 5; tr1++) {
          for(tr2 = tr1 + 1; tr2 <= 6; tr2++) {
            dmg = wp - bdef
            if(tr1 > 0 && tr1 < 4) dmg += tr1
            if(tr2 > 0 && tr2 < 4) dmg += tr2
            if(dmg < 1) dmg = 1
            def = am
            if(tr1 > 3) def += tr1 - 3
            if(tr2 > 3) def += tr2 - 3

            received = batk - def
            if(received < 1) received = 1
            turns = ceil(hp / received)
            totaldmg = dmg * turns
            if(totaldmg >= bhp) {
              turns = ceil(bhp / dmg)
              received = received * (turns - 1)
            } else {
              received = received * turns
            }
            if((totaldmg >= bhp) != victory) continue

            cost = weapons[wp]
            if(am) cost += armours[am]
            if(tr1 > 0) cost += trinkets[tr1]
            if(tr2 > 0) cost += trinkets[tr2]

            printf "%dg\t%dtrn\t", cost, turns
            if(victory) printf "%dhp\t", hp - received
            else printf "%dbhp\t", bhp - totaldmg
            printf "%10s\t", weaponnames[wp]
            printf "%9s\t", armournames[am]
            if(tr1 > 0 && tr1 < 4) printf "Dmg+%d", tr1
            if(tr1 > 3) printf "Def+%d", tr1 - 3
            printf "\t"
            if(tr2 > 0 && tr2 < 4) printf "Dmg+%d", tr2
            printf "\t"
            if(tr2 > 3) printf "Def+%d", tr2 - 3
            printf "\t"
            printf "%2ddmg\t%2ddef\n", dmg, def
          }
        }
      }
    }
  }
}

function ceil(x) {
  if(!(x % 1)) return x
  return 1 + sprintf("%d", x)
}
