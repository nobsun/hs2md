-- # Marp document from Haskell Script
-- 
{-# LANGUAGE MultiWayIf #-}

module Main where

import System.FilePath
import System.Environment
import System.IO

import TextFilter
import Hs2Md
-- 
-- ---
-- 
-- ## Command
-- 
main :: IO ()
main = mapM_ mkmd =<< getArgs

mkmd :: FilePath -> IO ()
mkmd fp = case drop 2 fp of
  src -> let des = "doc/" </> (src -<.> "md") in fileProc src des haskellToMarkdown
