---
marp: true
theme: gaia
class: invert
style: |
  p br {
    display: none
  }
---

# hs2md

- hs2md : 文芸的ではない Haskell スクリプトから Markdown（marp 用）による文芸的 Haskell スクリプトへの変換
- md2hs : Markdown（marp 用）による文芸的 Haskell スクリプトから 文芸的ではない Haskell スクリプトへの変換

---

## 注意

``hs2md``は，Haskell スクリプトにある``-- ``から始まる行をコメント行とみなす．
以下の部分はコメントと見なさない．

- 行の途中からはじまる``-- ``以降，行末までの部分
- ``{-``と``-}``で囲まれた（``-- ``から始まる行を除く）部分
