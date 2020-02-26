-- # Make doc directory
--
module Main where

import System.Environment (getArgs)
import System.Directory (createDirectoryIfMissing)

main :: IO ()
main = mapM_ (createDirectoryIfMissing True . ("doc/"++) . drop 2) =<< getArgs


