# Revision history for commutative-semigroups

## Unreleased

- `Commutative (Product a)` now merely requires `CommutativeProduct a`.
  `CommutativeProduct` is a new class to indicate `(*)` from Num is
  commutative, which is not required by `Num`.`

## 0.0.2.0 -- 2022-03-26

- Add `instance Ord a => Commutative (Set a)`
- Add `instance Commutative IntSet`

## 0.0.1.0 -- 2021-01-28

- Add instance for `Maybe`.

## 0.0.0.0 -- 2021-01-06

Initial version, created from `groups` package.
