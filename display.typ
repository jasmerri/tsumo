#import "@preview/cetz:0.2.2"
#import "./builtin.typ": resolver
#import "./mpsz.typ": parse-mpsz
#import "./tile.typ": tiles, types

#let style = (
  height: 4em,
  padding: 4pt,
  indicator-offset: 1pt
)

#let drawer(x, y, spec, style: style, resolver: none, name: none) = {
  import cetz.draw: *

  let front = (resolver.front)(height: style.height)
  let size = measure(front)

  let backdrop = front
  let image = (resolver.resolve-tile)(spec.tile, width: size.width - 2 * style.padding)
  
  if spec.tile.type == types.other {
    if spec.tile.which == tiles.other.nothing {
      backdrop = none
      image = none
    } else if(spec.tile.which == tiles.other.back) {
      backdrop = (resolver.back)(height: style.height)
      image = none
    }
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
  
  let gr = group(name: name, ctx => {
    for i in array.range(stack) {
      group(ctx => {
        let offset = i * if rotated {size.width} else {size.height}
        translate((x, y, 0))
        translate((0, offset, 0))
        if rotated {
          rotate(90deg)
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

#let display(specs, style: style, resolver: resolver, drawer: drawer) = {
  context {
    cetz.canvas({
      import cetz.draw: *
      let a = 0pt
      for spec in specs {
        let res = drawer(a, 0pt, spec, style: style, resolver: resolver)
        a += res.width
        res.element
      }
    })
  }
}

#let mpsz(str, ..args) = display(parse-mpsz(str), ..args)
