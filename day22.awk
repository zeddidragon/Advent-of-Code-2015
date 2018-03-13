#!/usr/bin/awk -f
/Hit Points/ { bhp = $3 }
/Damage/ { batk = $2 }
END {
  hp = 50
  if(mode == "hard") hp += 1
  mana = 500

  spells[1] = "Magic missile"
  spellcosts[1] = 53
  spelldmgs[1] = 4

  spells[2] = "Drain"
  spellcosts[2] = 73
  spelldmgs[2] = 2
  spellheals[2] = 2

  spells[3] = "Shield"
  spellcosts[3] = 113
  spelldurations[3] = 6

  spells[4] = "Poison"
  spellcosts[4] = 173
  spelldurations[4] = 6

  spells[5] = "Recharge"
  spellcosts[5] = 229
  spelldurations[5] = 5


  # Give player extra HP and boss first strike to save repetition
  state = statestring(0, 0, bhp, hp + batk, mana, "", "")

  states[state] = 0

  while(1) astar()
}

function statestring(t, c, b, h, m, as, a, es,   i) {
  estr = ""
  for(effect in es) {
    if(!effect) continue
    if(estr) estr = estr "|"
    estr = estr effect "|" es[effect]
  }
  if(as) as = "|" as
  as = a as
  return t SUBSEP c SUBSEP b SUBSEP h SUBSEP m SUBSEP as SUBSEP estr
}

function astar() {
  cheapest = ""
  cheapest_cost = ""

  for(state in states) {
    cost = states[state]
    if(cheapest && cost >= cheapest_cost) continue
    cheapest = state
    cheapest_cost = cost
  }

  if(!cheapest) {
    print "failed"
    exit
  }

  state = cheapest
  delete states[state]

  split(cheapest, data, SUBSEP)
  turn = data[1]
  cost = data[2]
  bhp = data[3]
  hp = data[4]
  mana = data[5]
  split(data[6], actions, "|")
  split(data[7], effectdata, "|")
  delete effects
  for(i in effectdata) {
    if(!(i % 2)) continue
    effect = effectdata[i]
    duration = effectdata[i + 1]
    effects[effect] = duration
  }

  if(mode == "hard") hp -= 1

  run_effects()
  check_victory("Post effects, player's turn")

  action = actions[1]
  if(mana < spellcosts[action]) return # Out of mana, dead end
  if(effects[action]) return # Effect already active, illegal move
  bhp -= spelldmgs[action]
  mana -= spellcosts[action]
  hp += spellheals[action]
  name = spells[action]
  if(spelldurations[action]) effects[name] = spelldurations[action]

  check_victory("Post player's turn")

  def = 0
  run_effects()
  check_victory("Post effects, boss' turn")
  dmg = batk - def
  if(dmg < 1) dmg = 1
  hp -= dmg

  if(hp < 1) return # Out of hp, dead end

  if(mode == "hard" && hp < 2) return # On hard mode, don't bother

  turn = turn + 1
  for(i = 1; i <= 5; ++i) {
    name = spells[i]
    new_cost = cost + spellcosts[i]
    new_state = statestring(turn, new_cost, bhp, hp, mana, data[5], i, effects)
    new_cost = bhp * new_cost
    states[new_state] = new_cost
  }
}

function run_effects(expired) {
  for(effect in effects) {
    duration = effects[effect]
    if(effect == "Shield") def += 7
    else if(effect == "Poison") bhp -= 3
    else if(effect == "Recharge") mana += 101

    duration -= 1
    if(duration > 0) {
      effects[effect] = duration
    } else {
      expired[effect] = 1
    }
  }

  for(effect in expired) delete effects[effect]
}

function check_victory(stage) {
  if(bhp > 0) return
  print cost
  exit
}
