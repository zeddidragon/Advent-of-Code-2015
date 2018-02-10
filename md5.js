#!/usr/bin/env node
const readline = require('readline')
const crypto = require('crypto')
const path = require('path')

const man = `
Usage: ${path.basename(__filename)} [OPTIONS]... [STRINGS]...
Print hashes from input or standard input.

With no STRINGS, stream standard input.

  -a <x>, --algo <x>      set hasing algorithm to x, default is md5
                          options: see -A

  -A, --algos             display a list of hashing algorithms and exit

  -d <x>, --digest <x>    set digest method to x, default is hex
                          options: hex, latin1, base64

  -i, --input             print input along with hash, seperated by tab
                          900150983cd24fb0d6963f7d28e17f72\tabc

  -e <x>, --encoding <x>  set encoding to x, default is utf8
                          options: utf8, ascii, latin1

  -h, --help              display this help and exit

Node's crypto module is used:  https://nodejs.org/api/cyrpto.html
`

let input = []
let algo = 'md5'
let digest = 'hex'
let encoding = 'utf8'
let showInput = false
for(let i = 2; i < process.argv.length; i += 1) {
  const arg = process.argv[i]
  const cmd = process.argv[i - 1]

  if(cmd === '-a' || cmd === '--algo') {
    algo = arg
  } else if(cmd === '-d' || cmd === '--digest') {
    digest = arg
  } else if(cmd === '-e' || cmd === '--encoding') {
    encoding = arg
  } else if(arg === '-h' || arg === '--help') {
    console.log(man.trim())
    return process.exit(0)
  } else if(arg === '-H' || arg === '--hashes') {
    console.log(crypto.getHashes().join('\n'))
    return process.exit(0)
  } else if(arg === '-i' || arg === '--input') {
    showInput = true
  } else {
    input.push(arg)
  }
}

function hash(str) {
  var hashed = crypto.createHash(algo).update(str, encoding).digest(digest)
  if(showInput) hashed += '\t' + str
  return hashed
}

if(input.length) {
  console.log(input.map(hash).join('\n'))
  process.exit(0)
}

process.on('SIGINT', () => process.exit(0))
process.stdout.on('error', process.exit)
process.stdin.on('end', () => process.exit(0))
process.stdin.setEncoding('utf8')

const pipe = readline.createInterface({
  input: process.stdin,
  output: process.stdout,
  terminal: false,
})

pipe.on('line', function(line) {
  process.stdout.write(hash(line) + '\n')
})
