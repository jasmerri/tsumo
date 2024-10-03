#import "./tile.typ": tiles, types, variants

#let digits = ("0", "1", "2", "3", "4", "5", "6", "7", "8", "9")
#let specials = ("X", "-", "?")
#let suits = ("m", "p", "s", "z")
#let ignored = (" ")

#let z = (
  "1": (which: tiles.wind.east, type: types.wind),
  "2": (which: tiles.wind.south, type: types.wind),
  "3": (which: tiles.wind.west, type: types.wind),
  "4": (which: tiles.wind.north, type: types.wind),
  "5": (which: tiles.dragon.white, type: types.dragon),
  "6": (which: tiles.dragon.green, type: types.dragon),
  "7": (which: tiles.dragon.red, type: types.dragon),
)

#let special = (
  "X": tiles.other.back,
  "-": tiles.other.nothing,
  "?": tiles.other.question,
)

#let suit = (
  "m": types.character,
  "p": types.dot,
  "s": types.bamboo,
)

#let numbers = (
  "1": (which: tiles.suit.one, variant: none),
  "2": (which: tiles.suit.two, variant: none),
  "3": (which: tiles.suit.three, variant: none),
  "4": (which: tiles.suit.four, variant: none),
  "5": (which: tiles.suit.five, variant: none),
  "6": (which: tiles.suit.six, variant: none),
  "7": (which: tiles.suit.seven, variant: none),
  "8": (which: tiles.suit.eight, variant: none),
  "9": (which: tiles.suit.nine, variant: none),
  "0": (which: tiles.suit.five, variant: variants.akadora),
)

#let generate-spec(state, symbol) = {
  let which = none
  let type = none
  let variant = none
  if specials.contains(state.char) {
    which = special.at(state.char)
    type = types.other
  } else if(symbol != none) {
    if symbol == "z" {
      let item = z.at(state.char, default: none)
      if item == none {
        panic("invalid tile in mpsz string: " + state.char + "z")
      }
      which = item.which
      type = item.type
    } else {
      let item = numbers.at(state.char)
      which = item.which
      type = suit.at(symbol)
      variant = item.variant
    }
  } else {
    panic("tile is missing a suit in mpsz string")
  }

  let attributes = (:)
  if "rotated" in state {
    attributes.rotated = state.rotated
  }
  if "stack" in state {
    attributes.stack = state.stack
  }

  return (
    tile: (which: which, type: type, variant: variant),
    attributes: attributes
  )
}

#let parse-mpsz(str) = {
  let tiles = ()
  let queued = ()

  for c in str {
    if digits.contains(c) or specials.contains(c) {
      let new = (char: c)
      queued.push(new)
    } else if suits.contains(c) {
      tiles += queued.map((q) => generate-spec(q, c))
      queued = ()
    } else if c == "'" or c == "\"" {
      if queued.len() <= 0 {
        panic("mpsz: trying to rotate nonexistent tile")
      }
      let previous = queued.at(-1)
      previous.rotated = true
      if c == "\"" {
        previous.stack = 2
      }
      queued.at(-1) = previous
    } else if ignored.contains(c) {
      // do nothing
    } else {
      panic("invalid character in mpsz string: " + c)
    }
  }

  tiles += queued.map((q) => generate-spec(q, none))
  queued = ()

  return tiles
}
