{-# LANGUAGE CPP           #-}
#if MIN_VERSION_base(4,12,0)
{-# LANGUAGE TypeOperators #-}
#endif

module Data.Semigroup.Commutative where

import Data.Monoid
import Data.Ord
import Data.List (unfoldr)
#if MIN_VERSION_base(4,7,0)
import Data.Proxy
#endif
#if !MIN_VERSION_base(4,11,0)
import Data.Semigroup (Semigroup(..))
#endif
#if MIN_VERSION_base(4,9,0)
import Data.Functor.Const
import Data.Functor.Identity
#endif
#if MIN_VERSION_base(4,12,0)
import Data.Functor.Contravariant (Op(Op))
import GHC.Generics
#endif

-- |An 'Abelian' group is a 'Group' that follows the rule:
--
-- @a \<> b == b \<> a@
class Semigroup g => Abelian g

instance Abelian ()

instance Num a => Abelian (Sum a)

instance Fractional a => Abelian (Product a)

instance Abelian a => Abelian (Dual a)

instance Abelian b => Abelian (a -> b)

instance (Abelian a, Abelian b) => Abelian (a, b)

instance (Abelian a, Abelian b, Abelian c) => Abelian (a, b, c)

instance (Abelian a, Abelian b, Abelian c, Abelian d) => Abelian (a, b, c, d)

instance (Abelian a, Abelian b, Abelian c, Abelian d, Abelian e) => Abelian (a, b, c, d, e)

#if MIN_VERSION_base(4,11,0)
instance Abelian a => Abelian (Down a)
#endif

#if MIN_VERSION_base(4,7,0)
-- | Trivial group, Functor style.
instance Abelian (Proxy x)
#endif

-- 'Const' has existed for a long time, but the Monoid instance
-- arrives in base-4.9.0.0. Similarly, 'Identity' was defined in
-- base-4.8.0.0 but doesn't get the Monoid instance until base-4.9.0.0
#if MIN_VERSION_base(4,9,0)
-- | 'Const' lifts groups into a functor.
instance Abelian a => Abelian (Const a x)

-- | 'Identity' lifts groups pointwise (at only one point).
instance Abelian a => Abelian (Identity a)
#endif

-- (:*:) and (:.:) exist since base-4.6.0.0 but the Monoid instances
-- arrive in base-4.12.0.0.
-- Also, contravariant was moved into base in this version.
#if MIN_VERSION_base(4,12,0)
-- | Product of groups, Functor style.
instance (Abelian (f a), Abelian (g a)) => Abelian ((f :*: g) a)

-- See https://gitlab.haskell.org/ghc/ghc/issues/11135#note_111802 for the reason Compose is not also provided.
-- Base does not define Monoid (Compose f g a) so this is the best we can
-- really do for functor composition.
instance Abelian (f (g a)) => Abelian ((f :.: g) a)

instance Abelian a => Abelian (Op a b)
#endif
