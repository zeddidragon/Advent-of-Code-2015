BEGIN {
  x = 0
  y = 0
  printf "%i,%i\n", x, y
}
{
  if($1 == "^") {
    y -= 1
  } else if($1 == "<") {
    x -= 1
  } else if($1 == "v") {
    y += 1
  } else if($1 == ">") {
    x += 1
  }
  printf "%i,%i\n", x, y
}
