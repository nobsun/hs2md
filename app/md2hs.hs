-- # Convert from Markdown to Haskell
-- 
{-# LANGUAGE MultiWayIf #-}
module Main where

import System.FilePath
import System.Environment
import System.IO

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
  { args <- getArgs
  ; case args of
      []         -> fileProc "-" "-" (markdownToHaskell Marp)
      inp:[]     -> case splitExtension inp of
        (fp,".md") -> fileProc inp (fp++".hs") (markdownToHaskell Marp)
        _          -> fileProc inp "-" (markdownToHaskell Marp)
      inp:outp:_ -> fileProc inp outp (markdownToHaskell Marp)
  }
