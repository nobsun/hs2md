-- ---
-- marp: true
--
-- ---

{-# LANGUAGE MultiWayIf #-}
module Lib
    ( someFunc
    ) where

import Control.Monad.Catch

someFunc :: IO ()
someFunc = putStrLn "someFunc"

proc :: FilePath -> (String -> String) -> IO ()
proc fp fun = undefined
  
