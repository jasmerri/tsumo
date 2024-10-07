#import "./tile.typ": ids, tiles, types, variants

#let _prefixes = (
  types.character: "Man",
  types.bamboo: "Sou",
  types.dot: "Pin",
  types.dragon: "",
  types.wind: "",
  types.other: "",
)

#let _suit-names = (
  ids.numbered.one: "1",
  ids.numbered.two: "2",
  ids.numbered.three: "3",
  ids.numbered.four: "4",
  ids.numbered.five: "5",
  ids.numbered.six: "6",
  ids.numbered.seven: "7",
  ids.numbered.eight: "8",
  ids.numbered.nine: "9",
)

#let _dragon-names = (
  ids.dragon.white: "Haku",
  ids.dragon.green: "Hatsu",
  ids.dragon.red: "Chun",
)

#let _wind-names = (
  ids.wind.east: "Ton",
  ids.wind.south: "Nan",
  ids.wind.west: "Shaa",
  ids.wind.north: "Pei",
)

#let _other-names = (
  ids.other.back: "Back",
  ids.other.question: "Blank",
  ids.other.blank: "Front",
)

#let _names = (
  types.character: _suit-names,
  types.bamboo: _suit-names,
  types.dot: _suit-names,
  types.dragon: _dragon-names,
  types.wind: _wind-names,
  types.other: _other-names,
)

#let _variant-names = (
  variants.akadora: "Dora",
)

#let _base = "./assets/Tiles/Riichi/"

#let _resolve-image-path(tile, ..args) = {
  let path = _base

  if tile == tiles.other.nothing {
    return none
  }
  
  if tile.type not in _prefixes {
    panic("invalid riichi tile type: " + tile.type)
  }
  path += _prefixes.at(tile.type)

  let n = _names.at(tile.type)
  if tile.which not in n {
    panic("invalid riichi tile: " + tile.type + "/" + tile.which + "/" + tile.variant)
  }
  path += n.at(tile.which)
  
  if tile.variant != none {
    if tile.variant not in _variant-names {
      panic("invalid riichi tile variant: " + tile.variant)
    }
    if tile.variant == variants.akadora and (
      (tile.type != types.character and tile.type != types.bamboo and tile.type != types.dot)
      or tile.which != ids.numbered.five
    ) {
      panic("invalid riichi tile for akadora: " + tile.which)
    }
    path += "-" + _variant-names.at(tile.variant)
  }
  image(path + ".svg", ..args)
}

// The default image resolver. Uses Riichi tiles from ./assets/Tiles/Riichi.
#let riichi = (
  // Return an image from a tile tuple.
  // The default drawer assumes this exists.
  resolve-tile: _resolve-image-path,

  // Image for the background of a face-up tile.
  // Note that this is used for calculation of tile sizes.
  // If your set of tiles doesn't have a background, this function should return blank content of the correct size.
  // The default drawer assumes this exists.
  front: (..args) => image(_base + "Front.svg", ..args),

  // Image for the background of a face-down tile.
  // The default drawer assumes this exists.
  back: (..args) => image(_base + "Back.svg", ..args),
)
