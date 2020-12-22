module Annotation where

data Annotation
    = BeginCode
    | Code
    | EndCode
    | Comment
    | Punctuation
    deriving (Eq, Show)

type BrInParagraph = Bool
