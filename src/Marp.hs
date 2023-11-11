{-# LANGUAGE OverloadedStrings #-}
module Marp where

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
headerFile = "doc/marp-header.yaml"

defaultHeader :: [T.Text]
defaultHeader =
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
    , "    font-family: 'HackGen Console NF';"
    , "  }"
    , "  li {"
    , "    font-size: 90%;"
    , "  }"
    , "  table {"
    , "    font-size: 15px;"
    , "  }"
    , "theme: default"
    , "paginate: true"
    , "math: katex"
    , ""
    , "---"
    , ""
    ]

