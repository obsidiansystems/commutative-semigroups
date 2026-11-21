{-# LANGUAGE CPP #-}
#if MIN_VERSION_base(4,17,0)
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE DerivingVia #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE UndecidableInstances #-}
#endif

-- Tests that 'Commutative' and its subclasses can be derived via 'Generically'
-- for product types.
--
-- The tests pass if this module compiles.
--
module Main (main) where

#if MIN_VERSION_base(4,17,0)

import Data.Semigroup.Commutative (Commutative)
import GHC.Generics (Generic, Generically (..), Rep)

--------------------------------------------------------------------------------
-- Introduction
--------------------------------------------------------------------------------

-- Normally, deriving a class via 'Generically' for a product type requires an
-- instance of that class for every single one of its field types.
--
-- For example, consider the following product type with two fields:

data Normal = Normal NormalField1 NormalField2
  deriving stock Generic
  deriving Semigroup via Generically Normal

newtype NormalField1 = NormalField1 () deriving Semigroup via ()
newtype NormalField2 = NormalField2 () deriving Semigroup via ()

-- In the above example, removing the 'Semigroup' instance for either of the
-- field types would prevent the compiler from deriving 'Semigroup' for the
-- product type.
--
-- This is because for any product type 'T', deriving 'Semigroup' via
-- 'Generically T' results in a definition of '(<>)' for 'T' that coerces
-- '(<>)' for 'Generically T', so the compiler is forced to find an instance of
-- 'Semigroup' for 'Generically T', which in turn requires an instance of
-- 'Semigroup' for each field type of 'T'.
--
-- In contrast, deriving 'Commutative' via 'Generically' for a product type
-- does /not/ require an instance of 'Commutative' for each of its field types.
--
-- Consider the following example:

data Unchecked = Unchecked UncheckedField1 UncheckedField2
  deriving stock Generic
  deriving (Semigroup, Commutative) via Generically Unchecked

newtype UncheckedField1 = UncheckedField1 () deriving Semigroup via ()
newtype UncheckedField2 = UncheckedField2 () deriving Semigroup via ()

-- Perhaps somewhat surprisingly, the above example compiles without any error,
-- even though neither of the field types is an instance of 'Commutative'.
--
-- Since the 'Commutative' class has no methods, the compiler is never forced
-- to build any coercions that actually require 'Commutative', and hence never
-- checks whether 'Generically Unchecked' is an instance of 'Commutative'.
-- (See GHC issue #12814.)
--
-- Now consider the following /subclass/ of 'Commutative', which /does/ have a
-- method:

class Commutative a => CommutativeSubclass a where
  combine :: a -> a -> a
  combine = (<>)

-- Let's make 'Generically' an instance of 'CommutativeSubclass':

instance (Generic a, Commutative (Rep a ())) =>
  CommutativeSubclass (Generically a)

-- Using this instance, we can derive 'CommutativeSubclass' for the following
-- 'Checked' product type, also with two fields:

data Checked = Checked CheckedField1 CheckedField2
  deriving stock Generic
  deriving (Semigroup, Commutative, CommutativeSubclass)
    via Generically Checked

newtype CheckedField1 = CheckedField1 ()
  deriving (Semigroup, Commutative) via ()

newtype CheckedField2 = CheckedField2 ()
  deriving (Semigroup, Commutative) via ()

-- Unlike the previous example, removing the 'Commutative' instance for either
-- field type results in a compiler error.
--
-- This is because for any product type 'T', deriving 'CommutativeSubclass' via
-- 'Generically T' results in a definition of 'combine' for 'T' that coerces
-- 'combine' for 'Generically T', so the compiler is forced to find an instance
-- of 'CommutativeSubclass' for 'Generically T', which in turn requires an
-- instance of 'Commutative' for each field type of 'T'.

--------------------------------------------------------------------------------
-- Coverage of generic representation types
--------------------------------------------------------------------------------

-- This section contains further examples of deriving 'Commutative' and
-- 'CommutativeSubclass' via 'Generically'.
--
-- Removing the 'Commutative' instance for any one field type should cause a
-- compiler error for every product type containing a field of that type.

data Empty
  deriving stock Generic
  deriving (Semigroup, Commutative, CommutativeSubclass) via Generically Empty

data P0 = P0
  deriving stock Generic
  deriving (Semigroup, Commutative, CommutativeSubclass) via Generically P0

data P1 = P1 F1
  deriving stock Generic
  deriving (Semigroup, Commutative, CommutativeSubclass) via Generically P1

data P2 = P2 F1 F2
  deriving stock Generic
  deriving (Semigroup, Commutative, CommutativeSubclass) via Generically P2

data P3 = P3 F1 F2 F3
  deriving stock Generic
  deriving (Semigroup, Commutative, CommutativeSubclass) via Generically P3

data P4 = P4 F1 F2 F3 F4
  deriving stock Generic
  deriving (Semigroup, Commutative, CommutativeSubclass) via Generically P4

newtype F1 = F1 () deriving (Semigroup, Commutative) via ()
newtype F2 = F2 () deriving (Semigroup, Commutative) via ()
newtype F3 = F3 () deriving (Semigroup, Commutative) via ()
newtype F4 = F4 () deriving (Semigroup, Commutative) via ()

#endif

main :: IO ()
main = pure ()
