#import "@preview/cetz:0.2.2"
#import "./image-sets.typ"
#import "./tile.typ": ids, tiles, types

// Default style used by the default drawer.
#let _style = (
  height: 4em,
  padding: 4pt,
  indicator-offset: 1pt
)

// The default drawer.
// Draws a tile given a specification.
// Arguments:
//   x, y: The position to draw the tile.
//   style: The style given to the function by the user.
//   image-set: The image set given to resolve images for tiles.
// Returns: a dictionary (
//   element: The Cetz element drawing the tile.
//   width: The width of the tile.
// )
#let drawer(x, y, spec, style: (:), image-set: image-sets.riichi) = {
  import cetz.draw: *
  let style = style + _style

  let front = (image-set.front)(height: style.height)
  let size = measure(front)

  let backdrop = front
  let image = (image-set.resolve-tile)(spec.tile, width: size.width - 2 * style.padding)
  
  if spec.tile == tiles.other.nothing {
    backdrop = none
    image = none
  } else if spec.tile == tiles.other.back {
    backdrop = (image-set.back)(height: style.height)
    image = none
  }

  let img-size = none
  if image != none {
    img-size = measure(image)
  }

  let rotated = false
  if spec.attributes.at("rotated", default: false) {
    rotated = true
  }
  let stack = spec.attributes.at("stack", default: 1)
  
  let gr = group(ctx => {
    for i in array.range(stack) {
      group(ctx => {
        let offset = i * if rotated {size.width} else {size.height}
        translate((x, y, 0))
        translate((0, offset, 0))
        if rotated {
          rotate(90deg)

        // A 90-deg rotation of the content will cause it to be offset. This fixes that.
          translate((0, -size.height, 0))
        }
        let anchor = "south-west"
        let angle = if rotated {90deg} else {0deg}
        if backdrop != none {
          content((0, 0), backdrop, anchor: anchor, angle: angle)
        }
        if image != none {
          content((style.padding, (size.height - img-size.height) / 2), image, anchor: anchor, angle: angle)
        }
      })
    }
  })

  return (
    element: gr,
    width: if rotated {size.height} else {size.width}
  )
}

// Given an array of tile specs, draw it onto a Cetz canvas.
#let display(specs, style: (:), image-set: image-sets.riichi, drawer: drawer) = {
  context {
    cetz.canvas({
      import cetz.draw: *
      let a = 0pt
      for spec in specs {
        let res = drawer(a, 0pt, spec, style: style, image-set: image-set)
        a += res.width
        res.element
      }
    })
  }
}
