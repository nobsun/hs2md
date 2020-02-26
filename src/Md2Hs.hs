{-# LANGUAGE MultiWayIf #-}
{-# LANGUAGE OverloadedStrings #-}
module Md2Hs where

import Data.Bool (bool)
import Data.Text (Text)
import qualified Data.Text as T
import qualified Data.Text.IO as T
import System.IO

import qualified Marp

type InCode = Bool

markdownToHaskell :: Handle -> Handle -> IO ()
markdownToHaskell ih oh = skip ih Marp.headersLength >> loop ih oh False

skip :: Handle -> Int -> IO ()
skip hdl n = case n of
  0 -> return ()
  n -> T.hGetLine hdl >> skip hdl (n-1)

loop :: Handle -> Handle -> Bool -> IO ()
loop ih oh flg = bool (md2hs ih oh flg =<< T.hGetLine ih) done =<< hIsEOF ih

md2hs :: Handle -> Handle -> InCode -> Text -> IO ()
md2hs ih oh flg line = case m2h flg line of
  (nflg, "")   -> bool nop (hPutStrLn oh "") flg >> loop ih oh nflg
  (nflg, ts) -> T.hPutStrLn oh ts >> loop ih oh nflg

m2h :: InCode -> Text -> (InCode, Text)
m2h flg line = if
  | flg -> if
      | endCode `T.isPrefixOf` line -> (False, "")
      | otherwise                   -> (flg, line)
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
