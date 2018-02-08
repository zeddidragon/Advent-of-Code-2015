BEGIN {
  total_area = 0;
  total_length = 0;
}
{
  side1 = $1 * $2
  side2 = $1 * $3
  side3 = $2 * $3
  total_area += side1 * 2 + side2 * 2 + side3 * 2
  total_length += $1 * $2 * $3
  if(side1 <= side2 && side1 <= side3) {
    total_area += side1
    total_length += $1 * 2 + $2 * 2
  } else if(side2 <= side3) {
    total_area += side2
    total_length += $1 * 2 + $3 * 2
  } else {
    total_area += side3
    total_length += $2 * 2 + $3 * 2
  }
}
END {
  printf "Part1: %i", total_area
  printf "\nPart2: %i", total_length
}
