#!/usr/bin/env coffee

#
# dice2pw
#
# Convert a set of dice rolls into a diceware password, given a diceware-formatted
# wordlist.
#
# Author: Brad Osgood
# Date: 12/22/2013
# Copyright: MIT

# Wordlist format:
# 11111 aword
# 11112 anotherword
# ...
# 66666 zlastword

fs = require 'fs'
PasswordLookup = require './dicelib'

usage = (msg) ->
  msg = msg or 'convert a set of dice rolls into a diceware password'
  console.log """
    dice2pw: #{msg}
    usage: diceware_list_file dice_roll [dice_roll, ...]
    where dice_roll is 6 digits from 1-6 like `123456'
  """

readDiceRolls = (argv, startIndex) ->
  rolls = []
  for i in [startIndex..argv.length - 1]
    roll = argv[i]
    if not roll?
      break
    rolls.push roll
  rolls

dicewareFile = process.argv[2]
unless dicewareFile?
  usage('missing diceware file')
  process.exit(1)

diceRolls = readDiceRolls(process.argv, 3)
unless diceRolls?.length > 0
  usage('unable to read dice rolls')
  process.exit(1)

wordlist = fs.readFile dicewareFile, 'utf8', (err, data) ->
  if err?
    usage("unable to load file: #{dicewareFile}")
    process.exit(2)

  db = new PasswordLookup(data.split('\n'))
  pw = db.getPasswordFromDiceRolls(diceRolls)
  console.log(pw)