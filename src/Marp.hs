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
  , "  p br {"
  , "    display: none;"
  , "  }"
  , "  code, pre {"
  , "    font-family: 'HackGenNerd Console';"
  , "  }"
  , "theme: defalut"
  , ""
  , "---"
  , ""
  ]

