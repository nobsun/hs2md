-- ---
-- marp: true
-- 
-- ---
-- 
-- # Convert to Haskell Script (non literate) to Markdown (marp format)

{-# LANGUAGE MultiWayIf #-}
module Main where

import Data.Bool (bool)
import Data.Char (isSpace)
import Data.List (isPrefixOf)
import System.IO (isEOF)

main :: IO ()
main = loop True

loop :: Bool -> IO ()
loop flg = bool (output flg) (done flg) =<< isEOF

output :: Bool -> IO ()
output flg = do
  { line <- getLine
  ; if
      | null (dropWhile isSpace line)   -> putStrLn line >> loop flg
      | commentPrefix `isPrefixOf` line -> bool (putStrLn "```") nop flg >> putStrLn (drop commentPrefixLength line) >> loop True
      | otherwise                       -> bool nop (putStrLn "```haskell") flg >> putStrLn line >> loop False
  }

nop :: IO ()
nop = return ()

commentPrefixLength :: Int
commentPrefixLength = length commentPrefix

commentPrefix :: String
commentPrefix = "-- "

done :: Bool -> IO ()
done = bool (putStrLn "```") (return ())
