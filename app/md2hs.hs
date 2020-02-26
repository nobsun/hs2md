-- # Convert to Markdown to Haskell Script (non literate)

{-# LANGUAGE MultiWayIf #-}
module Main where

import System.FilePath
import System.Environment
import System.IO

import TextFilter
import Md2Hs

main :: IO ()
main = do
  { args <- getArgs
  ; case args of
      []         -> fileProc "-" "-" markdownToHaskell
      inp:[]     -> case splitExtension inp of
        (fp,".md") -> fileProc inp (fp++".hs") markdownToHaskell
        _          -> fileProc inp "-" markdownToHaskell
      inp:outp:_ -> fileProc inp outp markdownToHaskell
  }


