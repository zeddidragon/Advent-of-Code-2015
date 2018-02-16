#!/usr/bin/awk -f
{
  json_data($0)
}

function trim(str) {
  sub(/^\s*/, "", str)
  sub(/\s*$/, "", str)
  return str
}

function json_data(str, path,  head, body) {
  str = trim(str)
  len = length(str)
  head = substr(str, 1, 1)
  body = substr(str, 2)
  if(head == "{") {
    json_object(body, path)
  } else if(head == "[") {
    json_array(body, path, 0)
  } else {
    print path "\t" json_literal(str)
  }
}

function json_object(str, path,   key) {
  key = json_key(str)
  str = substr(str, length(key) + 2)
  json_data(str, path " " key)
}

function json_array(str, path, i,   key) {
  comma = match(str, /,/)
  key = " [" i "]"
  if(i > 5) exit
  if(comma) {
    json_data(substr(str, 1, comma - 1), path key)
    json_array(substr(str, comma + 1), path, i + 1)
  } else {
    json_data(str, path key)
  }
}

function json_key(str) {
  len = match(str, /:/)
  return trim(substr(str, 1, len - 1))
}

function json_literal(str) {
  len = match(str, /,/)
  if(len) return trim(substr(str, 1, len - 1))
  return trim(str)
}
