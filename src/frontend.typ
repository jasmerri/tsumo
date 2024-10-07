#import "./display.typ": display
#import "./mpsz.typ": parse-mpsz

#let mahjong = (input, ..args, parser: parse-mpsz) => display(parser(input), ..args)
