-- # Marp document from Haskell Script
-- 
{-# LANGUAGE MultiWayIf #-}

module Main where

import Data.Char
import Data.List
import System.FilePath
import System.Environment
import System.IO

import TextFilter
import Hs2Md
import MD
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
  | otherwise             -> Marp
  where
    s' = map toLower s
