BEGIN {
  depth = 0;
  n = 0;
  first_negative = -1;
}
{
  if($1 == "(") {
    depth += 1;
  } else {
    depth -= 1;
  }
  if(depth < 0 && first_negative < 0) {
    first_negative = n;
  }
  n += 1;
}
END {
  printf "Part 1: %i", depth;
  printf "\nPart 2: %i", first_negative;
}
