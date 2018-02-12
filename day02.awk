#!/usr/bin/awk -f
BEGIN {
  total_area = 0;
  total_length = 0;
}
{
  if($1 <= $2 && $2 <= $3) {
    a = $1
  } else if($1 <= $2) {
    a = $3
    $3 = $2
    $2 = $1
  } else {
    a = $2
    $2 = $1
  }
  if($2 <= $3) {
    b = $2
    c = $3
  } else {
    b = $3
    c = $2
  }

  side1 = a * b # Guaranteed to be smallest
  side2 = a * c
  side3 = b * c

  # Add each of the six sides, smallest side one extra time
  total_area += side1 * 3 + side2 * 2 + side3 * 2

  # Add volume
  total_length += a * b * c
  # Add circumference of smallest side
  total_length += a * 2 + b * 2
}
END {
  printf "Part1: %i", total_area
  printf "\nPart2: %i", total_length
}
