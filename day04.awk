BEGIN {
  part = 1
}
NR % 29 == 0 {
  printf "\rPart %i: %i (%s)", part, NR, $1
}
/^000000/ {
  printf "\rPart 2: %i (%s)\n", NR, $1
  exit
}
/^00000/ {
  if(part == 1) {
    part = 2
    printf "\rPart 1: %i (%s)\n", NR, $1
  }
}
