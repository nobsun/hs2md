{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE MultiWayIf #-}
{-# LANGUAGE OverloadedStrings #-}
module Md2Hs where

import Data.Bool (bool)
import Data.Maybe
import Data.Text (Text)
import qualified Data.Text as T
import qualified Data.Text.IO as T
import System.IO ( Handle, hIsEOF, hPutStrLn )

import qualified Marp
import qualified Zenn
import MD

import Debug.Trace

type InCode = Bool

markdownToHaskell :: Handle -> Handle -> IO ()
markdownToHaskell ih oh
    = (maybe nop (T.hPutStrLn oh) <$> removeHeader ih) >> loop ih oh False

loop :: Handle -> Handle -> InCode -> IO ()
loop ih oh flg = bool (md2hs flg ih oh =<< T.hGetLine ih) done =<< hIsEOF ih

removeHeader :: Handle -> IO (Maybe T.Text)
removeHeader ih = do
  { eof <- hIsEOF ih
  ; if eof then return Nothing
    else do { ln <- T.stripEnd <$> T.hGetLine ih
            ; if ln /= "---" then return (Just ln) else iter
            }
  }
    where
        iter = bool (return Nothing)
                    (bool iter (return Nothing) . (== "---") . T.stripEnd =<< T.hGetLine ih)
             =<< hIsEOF ih

const' :: a -> b -> a
const' x !y = x

md2hs :: InCode -> Handle -> Handle -> Text -> IO ()
md2hs flg ih oh line = case m2h flg line of
  (flg',"") -> loop ih oh flg'
  (flg',ts) -> T.hPutStrLn oh ts >> loop ih oh flg

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
