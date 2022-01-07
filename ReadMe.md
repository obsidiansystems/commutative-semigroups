# Commutative Semigroup

[![Haskell](https://img.shields.io/badge/language-Haskell-orange.svg)](https://haskell.org) [![Hackage](https://img.shields.io/hackage/v/commutative-semigroup.svg)](https://hackage.haskell.org/package/commutative-semigroup) [![Hackage CI](https://matrix.hackage.haskell.org/api/v2/packages/commutative-semigroup/badge)](https://matrix.hackage.haskell.org/#/package/commutative-semigroup)  [![BSD3 License](https://img.shields.io/badge/license-BSD3-blue.svg)](https://github.com/reflex-frp/commutative-semigroup/LICENSE)

A commutative semigroup is a semigroup where the order of arguments to mappend does not matter.

```haskell
class Semigroup g => Commutative g
```
