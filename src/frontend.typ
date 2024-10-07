#import "./display.typ": display
#import "./parser.typ"

#let mahjong(input, ..args, parser: parser.mpsz) = {
  let parser = if parser == none { a => a } else { parser }
  return display(parser(input), ..args)
}
