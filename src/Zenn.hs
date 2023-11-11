{-# LANGUAGE OverloadedStrings #-}
module Zenn where

import qualified Data.Text as T
import qualified Data.Text.IO as T
import System.Directory

headerLength :: IO Int
headerLength = length <$> header

header :: IO [T.Text]
header = do
    { hd <- doesFileExist headerFile
    ; if hd then T.lines <$> T.readFile headerFile else return defaultHeader
    }

headerFile :: FilePath
headerFile = "doc/zenn-header.yaml"

defaultHeader :: [T.Text]
defaultHeader = 
    [ "---"
    , "title: "
    , "emoji: \"🇭\""
    , "type: \"tech\""
    , "topics: [\"Haskell\",\"関数プログラミング\"]"
    , "published: false"
    , "---"
    , ""
    ]

