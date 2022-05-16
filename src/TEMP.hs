module TEMP
  ( CommutativeProduct (..)
  )
  where

import Data.Int
import Data.Word

class Num a => CommutativeProduct a

instance CommutativeProduct Int8
instance CommutativeProduct Int16
instance CommutativeProduct Int32
instance CommutativeProduct Int64
instance CommutativeProduct Int
instance CommutativeProduct Word8
instance CommutativeProduct Word16
instance CommutativeProduct Word32
instance CommutativeProduct Word64
instance CommutativeProduct Word
