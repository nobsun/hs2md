-- # Convert from Markdown to Haskell
-- 
{-# LANGUAGE MultiWayIf #-}

module Main where

import Data.Char
import Data.List
import System.FilePath
import System.Environment

import TextFilter
import Md2Hs
import MD
-- 
-- ---
-- 
-- ## Command
-- 
main :: IO ()
main = do
    { prog <- getProgName
    ; args <- getArgs
    ; case args of
          []            -> fileProc "-" "-" markdownToHaskell
          inp:[]        -> case splitExtension inp of
              (fp,".md")    -> fileProc inp (fp++".hs") markdownToHaskell
              _             -> fileProc inp "-"         markdownToHaskell
          inp:outp:_   -> fileProc inp outp markdownToHaskell
    }

md :: String -> MD
md s = if
    | "marp" `isInfixOf` s' -> Marp
    | "zenn" `isInfixOf` s' -> Zenn
    | otherwise             -> Gfm
    where
        s' = map toLower s