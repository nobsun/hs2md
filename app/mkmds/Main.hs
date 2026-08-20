-- # Marp document from Haskell Script
-- 
{-# LANGUAGE MultiWayIf #-}

module Main where

import Data.Char ( toLower )
import Data.List ( isInfixOf )
import System.FilePath ( (-<.>), (</>) )
import System.Environment ( getArgs, getProgName )

import TextFilter ( fileProc )
import Hs2Md ( haskellToMarkdown )
import MD ( MD (Marp, Zenn, Gfm) )
-- 
-- ---
-- 
-- ## Command
-- 
main :: IO ()
main = do
  { prog <- getProgName
  ; mapM_ (mkmd (md prog)) =<< getArgs
  }

mkmd :: MD -> FilePath -> IO ()
mkmd md fp = case drop 2 fp of
  src -> let des = "doc/" </> (src -<.> "md") in fileProc src des (haskellToMarkdown md)

md :: String -> MD
md s = if
  | "marp" `isInfixOf` s' -> Marp
  | "zenn" `isInfixOf` s' -> Zenn
  | otherwise             -> Gfm
  where
    s' = map toLower s
