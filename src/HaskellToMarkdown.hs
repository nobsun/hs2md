{-# LANGUAGE LambdaCase #-}
{-# LANGUAGE MultiWayIf #-}
{-# LANGUAGE TupleSections #-}
{-# LANGUAGE OverloadedStrings #-}
module HaskellToMarkdown where

import Data.List
import qualified Data.Text as T

inComment :: Bool
inComment = True

classify :: T.Text -> [(Bool, [T.Text])]
classify = unfoldr psi . (inComment,) . T.lines
    where
        psi = \ case
            (_, [])     -> Nothing
            (True, lls) -> case span (T.isPrefixOf "--") lls of
                (xs, ys)    -> case xs of
                    []          -> Just ((True, xs), (False, ys))
