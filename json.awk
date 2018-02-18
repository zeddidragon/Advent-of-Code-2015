#!/usr/bin/awk -f
BEGIN {
  depth = 0
  push_mode("pre-value")
}
{
  len = length($0)
  split($0, data, "")
  for(i = 1; i <= len; ++i) {
    char = data[i]
    if(mode == "pre-value") {
      if(char == "{") {
        pop_mode()
        push_mode("pre-object-key")
        ++depth
      } else if(char == "[") {
        pop_mode()
        push_mode("post-array-value")
        push_mode("pre-value")
        ++depth
        path[depth] = "0"
      } else if(char == "\"") {
        pop_mode()
        push_mode("parse-string-value")
        push_mode("parse-string")
        value = char
      } else if(char ~ /[0-9]|-/) {
        pop_mode()
        push_mode("parse-number")
        value = char
      } else if(char == " ") {
        # Ignore whitespace
      } else if(char == "n" && substr($0, i, 4) == "null") {
        value = "null"
        i += 3
        print_value()
      } else {
        unexpected_token(char, i)
      }
    } else if(mode == "parse-number") {
      # Number spec is more complicated but integer is fine for now
      if(char ~ /[0-9]/) {
        value = value char
      } else {
        print_value()
        i -= 1
      }
    } else if(mode == "parse-string") {
      # String spec is more complicated, but this is fine for now
      value = value char
      if(char != "\"") continue
      pop_mode()
      if(mode == "parse-object-key") {
        path[depth] = value
        pop_mode()
      } else if(mode == "parse-string-value") {
        print_value()
      }
    } else if(mode == "post-array-value") {
      if(char == ",") {
        path[depth] += 1
        push_mode("pre-value")
      } else if(char == "]") {
        pop_depth()
        pop_mode()
      } else if(char == " ") {
        # Ignore whitespace
      } else {
        unexpected_token(char, i)
      }
    } else if(mode == "pre-object-key") {
      if(char == "\"") {
        value = char
        pop_mode()
        push_mode("post-object-key")
        push_mode("parse-object-key")
        push_mode("parse-string")
      } else if(char == " ") {
        # Ignore whitespace
      } else {
        unexpected_token(char, i)
      }
    } else if(mode == "post-object-key") {
      if(char == ":") {
        pop_mode()
        push_mode("post-object-value")
        push_mode("pre-value")
      } else if(char == " ") {
        # Ignore whitespace
      } else {
        unexpected_token(char, i)
      }
    } else if(mode == "post-object-value") {
      if(char == ",") {
        pop_mode()
        push_mode("pre-object-key")
      } else if(char == "}") {
        pop_depth()
        pop_mode()
      } else if(char == " ") {
        # Ignore whitespace
      } else {
        unexpected_token(char, i)
      }
    }
  }

  if(mode == "parse-number") {
    print_value()
  } else if(mode != "") {
    print "Unexpected end of file"
  }
}

function print_value(  i) {
  if(depth) {
    printf "["
    for(i = 1; i < depth; ++i) {
      printf "%s,", path[i]
    }
    printf "%s]\t", path[depth]
  }
  print value
  pop_mode()
  if(depth < 1) exit
}

function push_mode(m) {
  mode = m
  mode_index++
  mode_stack[mode_index] = m
}

function pop_mode(m) {
  delete mode_stack[mode_index]
  mode_index--
  mode = mode_stack[mode_index]
}

function pop_depth() {
  delete path[depth]
  --depth
}

function unexpected_token(char, i) {
  printf "Unexpected token \"%s\" at position %i\n", char, i
  exit 1
}
