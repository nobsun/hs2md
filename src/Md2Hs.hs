{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE MultiWayIf #-}
{-# LANGUAGE OverloadedStrings #-}
module Md2Hs where

import Data.Bool (bool)
import Data.Text (Text)
import qualified Data.Text as T
import qualified Data.Text.IO as T
import System.IO ( Handle, hIsEOF, hPutStrLn )

import qualified Marp
import qualified Zenn
import MD

import Debug.Trace

type InCode = Bool

markdownToHaskell :: MD -> Handle -> Handle -> IO ()
markdownToHaskell md ih oh = case md of
    Marp     -> loop ih oh False =<< Marp.headerLength
    Zenn     -> loop ih oh False =<< Zenn.headerLength
    Other fp -> loop ih oh False . length . lines =<< readFile fp

loop :: Handle -> Handle -> InCode -> Int -> IO ()
loop ih oh flg 0 = bool (md2hs flg ih oh =<< T.hGetLine ih) done =<< hIsEOF ih
loop ih oh flg n = bool (const' (loop ih oh flg (n-1)) =<< T.hGetLine ih) done =<< hIsEOF ih

const' :: a -> b -> a
const' x !y = x

md2hs :: InCode -> Handle -> Handle -> Text -> IO ()
md2hs flg ih oh line = case m2h flg line of
  (flg',"") -> loop ih oh flg' 0
  (flg',ts) -> T.hPutStrLn oh ts >> loop ih oh flg 0

m2h :: InCode -> Text -> (InCode, Text)
m2h flg line = if
    | flg       -> if
        | endCode `T.isPrefixOf` line   -> (False, "")
        | otherwise                     -> (flg, line)
    | otherwise -> if
        | beginCode `T.isPrefixOf` line -> (True, "")
        | otherwise                     -> (flg, T.append "-- " line)

nop :: IO ()
nop = return ()

done :: IO ()
done = return ()

beginCode :: Text
beginCode = "```haskell"

endCode :: Text
endCode = "```"
