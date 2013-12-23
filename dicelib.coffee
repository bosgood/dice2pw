# Contains mappings between dice roll digits and passwords
class PasswordLookup
  # 11111 aword
  # 11112 anotherword
  # ...
  # 66666 zlastword
  constructor: (pwPairs, delim) ->
    @lookup = @_parsePairs(pwPairs)

  _parsePairs: (pairs, delim = /\s/) ->
    index = {}
    for pair in pairs
      [key, word] = pair.split(delim)
      index[key] = word
    index

  getPasswordFromDiceRoll: (roll) ->
    @lookup[roll.trim()]

  getPasswordFromDiceRolls: (rolls) ->
    rolls.map (roll) =>
      @getPasswordFromDiceRoll(roll)
    .join(' ')

if module?.exports?
  module.exports = PasswordLookup
else if require? and define?
  define([], PasswordLookup)
else if window?
  window.PasswordLookup = PasswordLookup