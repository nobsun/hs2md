{-# LANGUAGE OverloadedStrings #-}
module Zenn where

import Data.Text (Text)

headersLength :: Int
headersLength = length headers

headers :: [Text]
headers = 
  [ "---"
  , "title: "
  , "emoji: \"🇭\""
  , "type: \"tech\""
  , "topics: [\"Haskell\",\"関数プログラミング\"]"
  , "published: false"
  , "---"
  , ""
  ]

