-- ---
-- marp: true
-- 
-- ---
-- 
-- # Convert to Markdown to Haskell Script (non literate)

{-# LANGUAGE MultiWayIf #-}
module Main where

import Data.Bool (bool)
import Data.Char (isSpace)
import Data.List (isPrefixOf)
import System.IO (isEOF)

main :: IO ()
main = loop False

loop :: Bool -> IO ()
loop flg = bool (output flg =<< getLine) done =<< isEOF

output :: Bool -> String -> IO ()
output flg line = if
  | flg -> if
      | endCode   `isPrefixOf` line -> loop False
      | otherwise                   -> putStrLn line >> loop flg
  | otherwise -> if
      | beginCode `isPrefixOf` line -> loop True
      | otherwise                   -> putStrLn ("-- " ++ line) >> loop flg

nop :: IO ()
nop = return ()

beginCode :: String
beginCode = "```haskell"

endCode :: String
endCode = "```"

done :: IO ()
done = return ()
