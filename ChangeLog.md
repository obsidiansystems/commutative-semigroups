# Revision history for commutative-semigroups

## 0.1.0.1 -- 2023-04-17

- Loosen version bounds
- Support GHC 9.6.1

## 0.1.0.0 -- 2022-06-12

- `Commutative (Product a)` now requires `CommutativeProduct a`.
  `CommutativeProduct` is a new class to indicate `(*)` from `Num` is
  commutative, which is not required by `Num`. (Example:
  multiplication on
  [quaternions](https://en.wikipedia.org/wiki/Quaternion) is
  non-commutative, and the `Quaternion a` type from the `linear`
  package has a valid `instance RealFloat a => Num (Quaternion a)`.)

  **Remark:** There is also no canonical subclass class in the `Num`
  hierarchy which implies commutative `(*)`, as both `Integral` and
  `Floating` instances work here:

  - `Integral` instances are customarily Euclidean Domains, which are
    commutative rings with extra conditions.

  - `Floating` instances customarily expect `(+)`, `(*)`, and `exp` to
    form an exponential field, which is also a commutative ring with
    extra conditions.

## 0.0.2.0 -- 2022-03-26

- Add `instance Ord a => Commutative (Set a)`
- Add `instance Commutative IntSet`

## 0.0.1.0 -- 2021-01-28

- Add instance for `Maybe`.

## 0.0.0.0 -- 2021-01-06

Initial version, created from `groups` package.
