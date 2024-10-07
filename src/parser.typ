#import "./tile.typ": ids, types, variants

#let _ignored = (" ")

#let _z = (
  "1": (which: ids.wind.east, type: types.wind),
  "2": (which: ids.wind.south, type: types.wind),
  "3": (which: ids.wind.west, type: types.wind),
  "4": (which: ids.wind.north, type: types.wind),
  "5": (which: ids.dragon.white, type: types.dragon),
  "6": (which: ids.dragon.green, type: types.dragon),
  "7": (which: ids.dragon.red, type: types.dragon),
)

#let _specials = (
  "X": ids.other.back,
  "-": ids.other.nothing,
  "?": ids.other.question,
)

#let _suits = (
  "m": types.character,
  "p": types.dot,
  "s": types.bamboo,
  "z": types.other,
)

#let _numbers = (
  "1": (which: ids.numbered.one,   variant: none),
  "2": (which: ids.numbered.two,   variant: none),
  "3": (which: ids.numbered.three, variant: none),
  "4": (which: ids.numbered.four,  variant: none),
  "5": (which: ids.numbered.five,  variant: none),
  "6": (which: ids.numbered.six,   variant: none),
  "7": (which: ids.numbered.seven, variant: none),
  "8": (which: ids.numbered.eight, variant: none),
  "9": (which: ids.numbered.nine,  variant: none),
  "0": (which: ids.numbered.five,  variant: variants.akadora),
)

#let _mpsz-generate-spec(state, symbol) = {
  let which = none
  let type = none
  let variant = none

  if state.char in _specials {
    which = _specials.at(state.char)
    type = types.other
  } else if(symbol != none) {
    if symbol == "z" {
      let item = _z.at(state.char, default: none)
      if item == none {
        panic("invalid tile in mpsz string: " + state.char + "z")
      }
      which = item.which
      type = item.type
    } else {
      let item = _numbers.at(state.char)
      which = item.which
      type = _suits.at(symbol)
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

// Parse an mpsz string and return an array of tile specs.
#let mpsz(str) = {
  let tiles = ()
  let queued = ()

  for c in str {
    if c in _numbers or c in _specials {
      // Add a new character.

      let new = (char: c)
      queued.push(new)
    } else if c in _suits {
      // Fill in the suit of all previous characters.

      tiles += queued.map((q) => _mpsz-generate-spec(q, c))
      queued = ()
    } else if c == "'" or c == "\"" {
      // Rotate previous tile.
      // Unlike LaTeX's mahjong package, this doesn't support being after a suit (1m' instead of 1'm).

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
      // Do nothing.
    } else {
      panic("invalid character in mpsz string: " + c)
    }
  }

  // Handle remaining tiles with no suit specified.
  tiles += queued.map((q) => _mpsz-generate-spec(q, none))
  queued = ()

  return tiles
}

// Turn an array of tiles into an array of tile specs with no attributes.
#let only-tiles(arr) = arr.map(v => (tile: v, attributes: (:)))
