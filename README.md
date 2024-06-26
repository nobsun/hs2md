# hs2md

## Haskell スクリプトから Markdown 文書への変換 `hs2md`

Haskell スクリプトのコメント部分を Markdown 文書とみなし、コード部分を Markdown文書のコードブロックに埋め込む
1. Haskell スクリプトにおいて、インラインコメント開始記号 `-- ` で開始された行をコメントとみなし、その行のコメント開始記号を削除
2. 1.以外の行はコードとみなし、Markdown のコードブロックに埋めこむ
3. （オプション）Markdown 文書の先頭にYAML形式ヘッダーを追加

#### 使い方
```sh
hs2md <Haskellファイル> [<Markdownファイル> [<YAMLヘッダーファイル>]]
```

## Markdown 文書から Haskell スクリプトへの変換 `md2hs`

Markdown 文書のコードブロック部分をHaskellスクリプトとし、コードブロック以外をコメントとする。

#### 使い方
```sh
md2hs <Markdownファイル> [<Haskellファイル>]
```

#### N.B.

``hs2md``は、Haskell スクリプトにある``-- ``から始まる行のみをコメント行とみなす。
以下の部分はコメントと見なさない。

- 行の途中からはじまる ``-- `` 以降，行末までの部分
- ``{-`` と ``-}`` で囲まれた（ ``-- `` から始まる行を除く）部分
f