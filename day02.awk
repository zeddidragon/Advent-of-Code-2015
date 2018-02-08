BEGIN {
  total_area = 0;
  total_length = 0;
}
{
  split($1, dims, "x")
  asort(dims)
  side1 = dims[1] * dims[2] # Guaranteed to be smallest because of asort
  side2 = dims[1] * dims[3]
  side3 = dims[2] * dims[3]

  # Add each of the six sides, smallest side one extra time
  total_area += side1 * 3 + side2 * 2 + side3 * 2
  # Add smalles

  # Add volume
  total_length += dims[1] * dims[2] * dims[3]
  # Add circumference of smallest side
  total_length += dims[1] * 2 + dims[2] * 2
}
END {
  printf "Part1: %i", total_area
  printf "\nPart2: %i", total_length
}
