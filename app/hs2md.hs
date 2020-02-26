-- # Converter from Haskell Script to Markdown
--
{-# LANGUAGE MultiWayIf #-}
module Main where

import System.FilePath
import System.Environment
import System.IO

import TextFilter
import Hs2Md

main :: IO ()
main = do
  { args <- getArgs
  ; case args of
      []         -> fileProc "-" "-" haskellToMarkdown
      inp:[]     -> case splitExtension inp of
        (fp,".hs") -> fileProc inp (fp++".md") haskellToMarkdown
        _          -> fileProc inp "-" haskellToMarkdown
      inp:outp:_ -> fileProc inp outp haskellToMarkdown
  }
