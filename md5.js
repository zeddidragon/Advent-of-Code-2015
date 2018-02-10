#!/usr/bin/env node
const readline = require('readline')
const crypto = require('crypto')

var data = ''
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
  const hash = crypto.createHash('md5').update(line).digest('hex')
  process.stdout.write(`${hash}\t${line}\t\n`)
})
