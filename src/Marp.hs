{-# LANGUAGE OverloadedStrings #-}
module Marp where

import Data.Text (Text)

headersLength :: Int
headersLength = length headers

headers :: [Text]
headers = 
  [ "---"
  , "marp: true"
  , "style: |"
  , "  section {"
  , "    font-family: 'Migu 1C';"
  , "  }"
  , "  p br {"
  , "    display: none;"
  , "  }"
  , "  code, pre {"
  , "    font-family: 'HackGen Console NFJ';"
  , "  }"
  , "theme: default"
  , "paginate: true"
  , ""
  , "---"
  , ""
  ]

