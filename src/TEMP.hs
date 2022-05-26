module TEMP
  ( CommutativeProduct (..)
  )
  where

import Data.Int
import Data.Word

-- | Subclass of 'Num' where '(*)' is commutative.
--
-- 'Num' doesn't demand commutative '(*)', and there are reasonable
-- "real-world" instances with non-commutative multiplication. There
-- is also no canonical subclass in @base@ that would suffice, as both
-- 'Integral' and 'Floating' imply commutative '(*)' for different
-- reasons.
--
-- Two examples of non-commutative '(*)':
--
-- * @Linear.Quaternion.Quaterion@ from the @linear@ package has a
--   'Num' instance, and quaternion multiplication is
--   noncommutative.
--
-- * @Data.Matrix.Matrix@ from the @matrix@ package uses '(*)' for
--   matrix multiplication, which is also non-commutative (on square
--   matrices, which is the only time the question makes sense).
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
