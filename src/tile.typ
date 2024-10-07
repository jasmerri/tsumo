// This file contains identifiers for the representation used by this library.
// Note that all ids are non-exhaustive. If you use your own set of tiles (i.e. a custom resolver),
// then you can use whichever ids you would like.


// Internal ids for tiles of some type.
// Used in the `which` field of a tile.
// These should *not* be used for comparing specific tiles; use `tiles` for that instead.
#let ids = (
  numbered: (
    one:   "1",
    two:   "2",
    three: "3",
    four:  "4",
    five:  "5",
    six:   "6",
    seven: "7",
    eight: "8",
    nine:  "9",
  ),
  dragon: (
    white: "white",
    green: "green",
    red: "red",
  ),
  wind: (
    east: "east",
    south: "south",
    west: "west",
    north: "north",
  ),
  flower: (
    one: "1",
    two: "2",
    three: "3",
    four: "4",

    plum: "1",
    orchid: "2",
    bamboo: "3",
    chrysanthemum: "4"
  ),
  season: (
    one: "1",
    two: "2",
    three: "3",
    four: "4",
    
    spring: "1",
    summer: "2",
    autumn: "3",
    winter: "4"
  ),
  other: (
    joker: "joker",
    question: "question",
    back: "back",
    blank: "blank",
    nothing: "nothing"
  )
)

// Ids for the type of a tile.
// Used in the `type` field of a tile.
#let types = (
  character: "manzu",
  bamboo: "souzu",
  dot: "pinzu",
  dragon: "dragon",
  wind: "wind",
  flower: "flower",
  season: "season",
  other: "other"
)

// Variant ids for a tile. a tile is exactly 1 variant: either the default variant (none), or something else.
// A different variant is effectively a completely different tile with a different visual.
// Used in the `variant` field of a tile.
#let variants = (
  akadora: "aka"
)

// Complete tiles. This dictionary should be used for specific tiles.
// Note that this dictionary is non-exaustive; you can create tiles which do not exist here.
// However, the default set of tiles will not be able to display them;
// so this is mostly useful if you are using your own set of tiles.
#let tiles = (
  character: (
    one:      (type: types.character, which: ids.numbered.one,   variant: none),
    two:      (type: types.character, which: ids.numbered.two,   variant: none),
    three:    (type: types.character, which: ids.numbered.three, variant: none),
    four:     (type: types.character, which: ids.numbered.four,  variant: none),
    five:     (type: types.character, which: ids.numbered.five,  variant: none),
    six:      (type: types.character, which: ids.numbered.six,   variant: none),
    seven:    (type: types.character, which: ids.numbered.seven, variant: none),
    eight:    (type: types.character, which: ids.numbered.eight, variant: none),
    nine:     (type: types.character, which: ids.numbered.nine,  variant: none),
    
    five-aka: (type: types.character, which: ids.numbered.five,  variant: variants.akadora),
  ),
  bamboo: (
    one:      (type: types.bamboo, which: ids.numbered.one,   variant: none),
    two:      (type: types.bamboo, which: ids.numbered.two,   variant: none),
    three:    (type: types.bamboo, which: ids.numbered.three, variant: none),
    four:     (type: types.bamboo, which: ids.numbered.four,  variant: none),
    five:     (type: types.bamboo, which: ids.numbered.five,  variant: none),
    six:      (type: types.bamboo, which: ids.numbered.six,   variant: none),
    seven:    (type: types.bamboo, which: ids.numbered.seven, variant: none),
    eight:    (type: types.bamboo, which: ids.numbered.eight, variant: none),
    nine:     (type: types.bamboo, which: ids.numbered.nine,  variant: none),
    
    five-aka: (type: types.bamboo, which: ids.numbered.five,  variant: variants.akadora),
  ),
  dot: (
    one:      (type: types.dot, which: ids.numbered.one,   variant: none),
    two:      (type: types.dot, which: ids.numbered.two,   variant: none),
    three:    (type: types.dot, which: ids.numbered.three, variant: none),
    four:     (type: types.dot, which: ids.numbered.four,  variant: none),
    five:     (type: types.dot, which: ids.numbered.five,  variant: none),
    six:      (type: types.dot, which: ids.numbered.six,   variant: none),
    seven:    (type: types.dot, which: ids.numbered.seven, variant: none),
    eight:    (type: types.dot, which: ids.numbered.eight, variant: none),
    nine:     (type: types.dot, which: ids.numbered.nine,  variant: none),
    
    five-aka: (type: types.dot, which: ids.numbered.five,  variant: variants.akadora),
  ),
  dragon: (
    white: (type: types.dragon, which: ids.dragon.white, variant: none),
    green: (type: types.dragon, which: ids.dragon.green, variant: none),
    red:   (type: types.dragon, which: ids.dragon.red,   variant: none),
  ),
  wind: (
    east:  (type: types.wind, which: ids.wind.east,  variant: none),
    south: (type: types.wind, which: ids.wind.south, variant: none),
    west:  (type: types.wind, which: ids.wind.west,  variant: none),
    north: (type: types.wind, which: ids.wind.north, variant: none),
  ),
  flower: (
    one:   (type: types.flower, which: ids.flower.one,   variant: none),
    two:   (type: types.flower, which: ids.flower.two,   variant: none),
    three: (type: types.flower, which: ids.flower.three, variant: none),
    four:  (type: types.flower, which: ids.flower.four,  variant: none),

    // Alternative names. They are the same; this is only for convenience.
    plum:          (type: types.flower, which: ids.flower.plum,          variant: none),
    orchid:        (type: types.flower, which: ids.flower.orchid,        variant: none),
    bamboo:        (type: types.flower, which: ids.flower.bamboo,        variant: none),
    chrysanthemum: (type: types.flower, which: ids.flower.chrysanthemum, variant: none),
  ),
  season: (
    one:   (type: types.season, which: ids.season.one,   variant: none),
    two:   (type: types.season, which: ids.season.two,   variant: none),
    three: (type: types.season, which: ids.season.three, variant: none),
    four:  (type: types.season, which: ids.season.four,  variant: none),
    
    // Alternative names. They are the same; this is only for convenience.
    spring: (type: types.season, which: ids.season.spring, variant: none),
    summer: (type: types.season, which: ids.season.summer, variant: none),
    autumn: (type: types.season, which: ids.season.autumn, variant: none),
    winter: (type: types.season, which: ids.season.winter, variant: none),
  ),
  other: (
    joker:    (type: types.other, which: ids.other.joker,    variant: none),
    
    // Question-marked tile.
    question: (type: types.other, which: ids.other.question, variant: none),

    // The back of a tile (i.e., one that's face-down).
    back:     (type: types.other, which: ids.other.back,     variant: none),

    // A blank tile. In Riichi sets, this is the same as the white dragon.
    blank:    (type: types.other, which: ids.other.blank,    variant: none),

    // No tile at all.
    nothing:  (type: types.other, which: ids.other.nothing,  variant: none),
  )
)
