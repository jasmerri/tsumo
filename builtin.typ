#import "./tile.typ": tiles, types, variants

#let prefixes = (
  types.character: "Man",
  types.bamboo: "Sou",
  types.dot: "Pin",
  types.dragon: "",
  types.wind: "",
  types.other: "",
)

#let suit-names = (
  tiles.suit.one: "1",
  tiles.suit.two: "2",
  tiles.suit.three: "3",
  tiles.suit.four: "4",
  tiles.suit.five: "5",
  tiles.suit.six: "6",
  tiles.suit.seven: "7",
  tiles.suit.eight: "8",
  tiles.suit.nine: "9",
)

#let dragon-names = (
  tiles.dragon.white: "Haku",
  tiles.dragon.green: "Hatsu",
  tiles.dragon.red: "Chun",
)

#let wind-names = (
  tiles.wind.east: "Ton",
  tiles.wind.south: "Nan",
  tiles.wind.west: "Shaa",
  tiles.wind.north: "Pei",
)

#let other-names = (
  tiles.other.back: "Back",
  tiles.other.question: "Blank",
)

#let names = (
  types.character: suit-names,
  types.bamboo: suit-names,
  types.dot: suit-names,
  types.dragon: dragon-names,
  types.wind: wind-names,
  types.other: other-names,
)

#let variant-names = (
  variants.akadora: "Dora",
)

#let base = "./assets/Tiles/Riichi/"

#let resolve-image-path(tile, ..args) = {
  let path = base

  if tile.type == types.other and tile.which == tiles.other.nothing {
    return none
  }
  
  if tile.type not in prefixes {
    panic("invalid riichi tile type: " + tile.type)
  }
  path += prefixes.at(tile.type)

  let n = names.at(tile.type)
  if tile.which not in n {
    panic("invalid riichi tile: " + tile.which)
  }
  path += n.at(tile.which)
  
  if tile.variant != none {
    if tile.variant not in variant-names {
      panic("invalid riichi tile variant: " + tile.variant)
    }
    if tile.variant == variants.akadora and (
      (tile.type != types.character and tile.type != types.bamboo and tile.type != types.dot)
      or tile.which != tiles.suit.five
    ) {
      panic("invalid riichi tile for akadora: " + tile.which)
    }
    path += "-" + variant-names.at(tile.variant)
  }
  image(path + ".svg", ..args)
}

#let resolver = (
  resolve-tile: resolve-image-path,
  front: (..args) => image(base + "Front.svg", ..args),
  back: (..args) => image(base + "Back.svg", ..args),
)
