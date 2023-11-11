{-# LANGUAGE OverloadedStrings #-}
module Hs2Md where

import Data.Bool (bool)
import Data.Text (Text)
import qualified Data.Text as T
import qualified Data.Text.IO as T
import System.IO ( Handle, hIsEOF, hPutStrLn )

import qualified Marp
import qualified Zenn
import MD ( MD(..) )

type InComment = Bool

haskellToMarkdown :: MD -> Handle -> Handle -> IO ()
haskellToMarkdown md ih oh = case md of
    Marp     -> Marp.header   >>= T.hPutStr oh . T.unlines >> loop ih oh True
    Zenn     -> Zenn.header   >>= T.hPutStr oh . T.unlines >> loop ih oh True
    Gfm      ->                                               loop ih oh True
    Other fp -> T.readFile fp >>= T.hPutStr oh             >> loop ih oh True

loop :: Handle -> Handle -> InComment -> IO ()
loop ih oh flg = hIsEOF ih >>= bool (T.hGetLine ih >>= hs2md ih oh flg) (done flg oh)

hs2md :: Handle -> Handle -> InComment -> Text -> IO ()
hs2md ih oh flg line = case h2m flg line of
    (nflg, ts) -> T.hPutStrLn oh ts >> loop ih oh nflg

h2m :: InComment -> Text -> (InComment, Text)
h2m flg line = case T.splitAt 3 line' of
    ("",_)      -> (flg, "")
    ("--",_)    -> (True,  bool "```\n" "" flg)
    ("-- ", cs) -> (True,  bool (T.intercalate "\n" ["```", cs]) cs flg)
    _           -> (False, bool line' (T.intercalate "\n" ["```haskell", line]) flg)
    where
        line' = T.stripEnd line
    
done :: InComment -> Handle -> IO ()
done flg hdl = bool (hPutStrLn hdl "```") (return ()) flg
