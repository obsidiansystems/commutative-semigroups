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

-- |An 'Commutative' semigroup is a 'Semigroup' that follows the rule:
--
-- @a \<> b == b \<> a@
class Semigroup g => Commutative g

instance Commutative ()

instance Num a => Commutative (Sum a)

instance Fractional a => Commutative (Product a)

instance Commutative a => Commutative (Dual a)

instance Commutative b => Commutative (a -> b)

instance (Commutative a, Commutative b) => Commutative (a, b)

instance (Commutative a, Commutative b, Commutative c) => Commutative (a, b, c)

instance (Commutative a, Commutative b, Commutative c, Commutative d) => Commutative (a, b, c, d)

instance (Commutative a, Commutative b, Commutative c, Commutative d, Commutative e) => Commutative (a, b, c, d, e)

#if MIN_VERSION_base(4,11,0)
instance Commutative a => Commutative (Down a)
#endif

#if MIN_VERSION_base(4,7,0)
-- | Trivial semigroup, Functor style.
instance Commutative (Proxy x)
#endif

-- 'Const' has existed for a long time, but the Monoid instance
-- arrives in base-4.9.0.0. Similarly, 'Identity' was defined in
-- base-4.8.0.0 but doesn't get the Monoid instance until base-4.9.0.0
#if MIN_VERSION_base(4,9,0)
-- | 'Const' lifts semigroups into a functor.
instance Commutative a => Commutative (Const a x)

-- | 'Identity' lifts semigroups pointwise (at only one point).
instance Commutative a => Commutative (Identity a)
#endif

-- (:*:) and (:.:) exist since base-4.6.0.0 but the Monoid instances
-- arrive in base-4.12.0.0.
-- Also, contravariant was moved into base in this version.
#if MIN_VERSION_base(4,12,0)
-- | Product of semigroups, Functor style.
instance (Commutative (f a), Commutative (g a)) => Commutative ((f :*: g) a)

-- See https://gitlab.haskell.org/ghc/ghc/issues/11135#note_111802 for the reason Compose is not also provided.
-- Base does not define Monoid (Compose f g a) so this is the best we can
-- really do for functor composition.
instance Commutative (f (g a)) => Commutative ((f :.: g) a)

instance Commutative a => Commutative (Op a b)
#endif
