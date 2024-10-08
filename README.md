# tsumo

tsumo is a Typst library for typesetting Mahjong tiles.

## Usage

tsumo provides a convenient interface for using MPSZ algebreic notation, a common notation used for describing Riichi Mahjong hands.
It supports the same notational extensions as the `mahjong` package for LaTeX.

```
  #import "@local/tsumo:0.1.0"

  #tsumo.mahjong("123s 55\"0m X22Xp")
```

![example generated hand](example.png)
