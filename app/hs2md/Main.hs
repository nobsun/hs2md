-- # Converter from Haskell to Markdown
-- 
{-# LANGUAGE GHC2024 #-}

module Main where

import Data.Char ( toLower )
import Data.List ( isInfixOf )
import System.FilePath ( splitExtension )
import System.Environment ( getArgs, getProgName )

import TextFilter ( fileProc )
import Hs2Md ( haskellToMarkdown )
import MD ( MD(Marp, Gfm, Other, Zenn) )
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
          []            -> fileProc "-" "-" (haskellToMarkdown (md prog))
          inp:[]        -> case splitExtension inp of
              (fp,".hs")      -> fileProc inp (fp++".md") (haskellToMarkdown (md prog))
              _               -> fileProc inp "-"         (haskellToMarkdown (md prog))
          inp:outp:[]   -> fileProc inp outp (haskellToMarkdown (md prog))
          inp:outp:hd:_ -> fileProc inp outp (haskellToMarkdown (Other hd))
    }

md :: String -> MD
md s = case map toLower s of
    s'
        | "marp" `isInfixOf` s' -> Marp
        | "zenn" `isInfixOf` s' -> Zenn
        | otherwise             -> Gfm
