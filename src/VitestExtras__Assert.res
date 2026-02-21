/**
 * Vitest Assert API bindings.
 *
 * These bindings wrap Vitest's chai-based assert API with ergonomic ReScript types.
 * Organized into submodules for type-specific assertions.
 */
/** Abstract type for the assert object from vitest */
type t

@module("vitest") @val external assertObj: t = "assert"

// ============================================================================
// Core Assertions
// ============================================================================

/** Asserts that `expression` is truthy. */
@send
external assert_: (t, 'a, ~message: string=?) => unit = "ok"

@inline
let assert_ = (~message=?, value) => assertObj->assert_(value, ~message?)

/** Force an assertion failure with an optional message. */
@module("vitest") @scope("expect")
external fail: (~message: string=?) => unit = "unreachable"

// ============================================================================
// Equality
// ============================================================================

@send external equalBinding: (t, 'a, 'a, ~message: string=?) => unit = "equal"

/** Non-strict equality comparison (==). */
@inline
let equal = (~message=?, actual, expected) => assertObj->equalBinding(actual, expected, ~message?)

@send external notEqualBinding: (t, 'a, 'a, ~message: string=?) => unit = "notEqual"

/** Non-strict inequality comparison (!=). */
@inline
let notEqual = (~message=?, actual, expected) =>
  assertObj->notEqualBinding(actual, expected, ~message?)

@send external strictEqualBinding: (t, 'a, 'a, ~message: string=?) => unit = "strictEqual"

/** Strict equality comparison (===). */
@inline
let strictEqual = (~message=?, actual, expected) =>
  assertObj->strictEqualBinding(actual, expected, ~message?)

@send external notStrictEqualBinding: (t, 'a, 'a, ~message: string=?) => unit = "notStrictEqual"

/** Strict inequality comparison (!==). */
@inline
let notStrictEqual = (~message=?, actual, expected) =>
  assertObj->notStrictEqualBinding(actual, expected, ~message?)

@send external deepEqualBinding: (t, 'a, 'a, ~message: string=?) => unit = "deepEqual"

/** Deep equality comparison. */
@inline
let deepEqual = (~message=?, actual, expected) =>
  assertObj->deepEqualBinding(actual, expected, ~message?)

@send external notDeepEqualBinding: (t, 'a, 'a, ~message: string=?) => unit = "notDeepEqual"

/** Deep inequality comparison. */
@inline
let notDeepEqual = (~message=?, actual, expected) =>
  assertObj->notDeepEqualBinding(actual, expected, ~message?)

// ============================================================================
// Numeric Comparisons
// ============================================================================

@send external isAboveBinding: (t, float, float, ~message: string=?) => unit = "isAbove"

/** Asserts that `value > target`. */
@inline
let isAbove = (~message=?, value, target) => assertObj->isAboveBinding(value, target, ~message?)

@send external isAtLeastBinding: (t, float, float, ~message: string=?) => unit = "isAtLeast"

/** Asserts that `value >= target`. */
@inline
let isAtLeast = (~message=?, value, target) => assertObj->isAtLeastBinding(value, target, ~message?)

@send external isBelowBinding: (t, float, float, ~message: string=?) => unit = "isBelow"

/** Asserts that `value < target`. */
@inline
let isBelow = (~message=?, value, target) => assertObj->isBelowBinding(value, target, ~message?)

@send external isAtMostBinding: (t, float, float, ~message: string=?) => unit = "isAtMost"

/** Asserts that `value <= target`. */
@inline
let isAtMost = (~message=?, value, target) => assertObj->isAtMostBinding(value, target, ~message?)

@send
external closeToBinding: (t, float, float, float, ~message: string=?) => unit = "closeTo"

/** Asserts that `actual` is within +/- `delta` of `expected`. */
@inline
let closeTo = (~message=?, actual, expected, ~delta) =>
  assertObj->closeToBinding(actual, expected, delta, ~message?)

/** Alias for `closeTo`. */
let approximately = closeTo

// ============================================================================
// Boolean Assertions
// ============================================================================

@send external isTrueBinding: (t, bool, ~message: string=?) => unit = "isTrue"

/** Asserts that `value` is exactly `true`. */
@inline
let isTrue = (~message=?, value) => assertObj->isTrueBinding(value, ~message?)

@send external isNotTrueBinding: (t, bool, ~message: string=?) => unit = "isNotTrue"

/** Asserts that `value` is not exactly `true`. */
@inline
let isNotTrue = (~message=?, value) => assertObj->isNotTrueBinding(value, ~message?)

@send external isFalseBinding: (t, bool, ~message: string=?) => unit = "isFalse"

/** Asserts that `value` is exactly `false`. */
@inline
let isFalse = (~message=?, value) => assertObj->isFalseBinding(value, ~message?)

@send external isNotFalseBinding: (t, bool, ~message: string=?) => unit = "isNotFalse"

/** Asserts that `value` is not exactly `false`. */
@inline
let isNotFalse = (~message=?, value) => assertObj->isNotFalseBinding(value, ~message?)

// ============================================================================
// NaN and Finite Assertions
// ============================================================================

@send external isNaNBinding: (t, float, ~message: string=?) => unit = "isNaN"

/** Asserts that `value` is `NaN`. */
@inline
let isNaN = (~message=?, value) => assertObj->isNaNBinding(value, ~message?)

@send external isNotNaNBinding: (t, float, ~message: string=?) => unit = "isNotNaN"

/** Asserts that `value` is not `NaN`. */
@inline
let isNotNaN = (~message=?, value) => assertObj->isNotNaNBinding(value, ~message?)

@send external isFiniteBinding: (t, float, ~message: string=?) => unit = "isFinite"

/** Asserts that `value` is finite (not NaN or Infinity). */
@inline
let isFinite = (~message=?, value) => assertObj->isFiniteBinding(value, ~message?)

// ============================================================================
// Regex Matching
// ============================================================================

@send external matchBinding: (t, string, RegExp.t, ~message: string=?) => unit = "match"

/** Asserts that `value` matches the regular expression. */
@inline
let match_ = (~message=?, value, regexp) => assertObj->matchBinding(value, regexp, ~message?)

@send external notMatchBinding: (t, string, RegExp.t, ~message: string=?) => unit = "notMatch"

/** Asserts that `value` does not match the regular expression. */
@inline
let notMatch = (~message=?, value, regexp) => assertObj->notMatchBinding(value, regexp, ~message?)

// ============================================================================
// oneOf
// ============================================================================

@send
external oneOfBinding: (t, 'a, array<'a>, ~message: string=?) => unit = "oneOf"

/** Asserts that `value` is one of the values in `list`. */
@inline
let oneOf = (~message=?, value, list) => assertObj->oneOfBinding(value, list, ~message?)

// ============================================================================
// Exception Assertions
// ============================================================================

@send external throwsBinding: (t, unit => 'a, ~message: string=?) => unit = "throws"

/** Asserts that `fn` throws an exception. */
@inline
let throws = (~message=?, fn) => assertObj->throwsBinding(fn, ~message?)

@send
external throwsWithMatchBinding: (t, unit => 'a, RegExp.t, ~message: string=?) => unit = "throws"

/** Asserts that `fn` throws an exception matching the regexp. */
@inline
let throwsWithMatch = (~message=?, fn, regexp) =>
  assertObj->throwsWithMatchBinding(fn, regexp, ~message?)

@send external doesNotThrowBinding: (t, unit => 'a, ~message: string=?) => unit = "doesNotThrow"

/** Asserts that `fn` does not throw an exception. */
@inline
let doesNotThrow = (~message=?, fn) => assertObj->doesNotThrowBinding(fn, ~message?)

// ============================================================================
// Object State Assertions
// ============================================================================

@send external isExtensibleBinding: (t, 'a, ~message: string=?) => unit = "isExtensible"

/** Asserts that `object` is extensible (can have new properties added). */
@inline
let isExtensible = (~message=?, object) => assertObj->isExtensibleBinding(object, ~message?)

@send external isNotExtensibleBinding: (t, 'a, ~message: string=?) => unit = "isNotExtensible"

/** Asserts that `object` is not extensible. */
@inline
let isNotExtensible = (~message=?, object) => assertObj->isNotExtensibleBinding(object, ~message?)

@send external isSealedBinding: (t, 'a, ~message: string=?) => unit = "isSealed"

/** Asserts that `object` is sealed (properties cannot be added or deleted). */
@inline
let isSealed = (~message=?, object) => assertObj->isSealedBinding(object, ~message?)

@send external isNotSealedBinding: (t, 'a, ~message: string=?) => unit = "isNotSealed"

/** Asserts that `object` is not sealed. */
@inline
let isNotSealed = (~message=?, object) => assertObj->isNotSealedBinding(object, ~message?)

@send external isFrozenBinding: (t, 'a, ~message: string=?) => unit = "isFrozen"

/** Asserts that `object` is frozen (cannot be modified at all). */
@inline
let isFrozen = (~message=?, object) => assertObj->isFrozenBinding(object, ~message?)

@send external isNotFrozenBinding: (t, 'a, ~message: string=?) => unit = "isNotFrozen"

/** Asserts that `object` is not frozen. */
@inline
let isNotFrozen = (~message=?, object) => assertObj->isNotFrozenBinding(object, ~message?)

// ============================================================================
// Null Assertions
// ============================================================================

module Null = {
  @send external isNullBinding: (t, 'a, ~message: string=?) => unit = "isNull"

  /** Asserts that `value` is `null`. */
  @inline
  let isNull = (~message=?, value: Null.t<'a>): unit => assertObj->isNullBinding(value, ~message?)

  @send external isNotNullBinding: (t, 'a, ~message: string=?) => unit = "isNotNull"

  /** Asserts that `value` is not `null`. */
  @inline
  let isNotNull = (~message=?, value: Null.t<'a>): unit =>
    assertObj->isNotNullBinding(value, ~message?)
}

// ============================================================================
// Undefined Assertions
// ============================================================================

module Undefined = {
  @send external isUndefinedBinding: (t, 'a, ~message: string=?) => unit = "isUndefined"

  /** Asserts that `value` is `undefined`. */
  @inline
  let isUndefined = (~message=?, value: undefined<'a>): unit =>
    assertObj->isUndefinedBinding(value, ~message?)

  @send external isDefinedBinding: (t, 'a, ~message: string=?) => unit = "isDefined"

  /** Asserts that `value` is not `undefined`. */
  @inline
  let isDefined = (~message=?, value: undefined<'a>): unit =>
    assertObj->isDefinedBinding(value, ~message?)
}

// ============================================================================
// Nullable Assertions (null | undefined | value)
// ============================================================================

module Nullable = {
  @send external isNullBinding: (t, 'a, ~message: string=?) => unit = "isNull"

  /** Asserts that `value` is `null`. */
  @inline
  let isNull = (~message=?, value: Nullable.t<'a>): unit =>
    assertObj->isNullBinding(value, ~message?)

  @send external isNotNullBinding: (t, 'a, ~message: string=?) => unit = "isNotNull"

  /** Asserts that `value` is not `null` (may still be undefined). */
  @inline
  let isNotNull = (~message=?, value: Nullable.t<'a>): unit =>
    assertObj->isNotNullBinding(value, ~message?)

  @send external isUndefinedBinding: (t, 'a, ~message: string=?) => unit = "isUndefined"

  /** Asserts that `value` is `undefined`. */
  @inline
  let isUndefined = (~message=?, value: Nullable.t<'a>): unit =>
    assertObj->isUndefinedBinding(value, ~message?)

  @send external isDefinedBinding: (t, 'a, ~message: string=?) => unit = "isDefined"

  /** Asserts that `value` is not `undefined` (may still be null). */
  @inline
  let isDefined = (~message=?, value: Nullable.t<'a>): unit =>
    assertObj->isDefinedBinding(value, ~message?)

  @send external existsBinding: (t, 'a, ~message: string=?) => unit = "exists"

  /** Asserts that `value` is neither `null` nor `undefined`. */
  @inline
  let exists = (~message=?, value: Nullable.t<'a>): unit =>
    assertObj->existsBinding(value, ~message?)

  @send external notExistsBinding: (t, 'a, ~message: string=?) => unit = "notExists"

  /** Asserts that `value` is `null` or `undefined`. */
  @inline
  let notExists = (~message=?, value: Nullable.t<'a>): unit =>
    assertObj->notExistsBinding(value, ~message?)
}

// ============================================================================
// Array Assertions
// ============================================================================

module Array = {
  @send external isEmptyBinding: (t, 'a, ~message: string=?) => unit = "isEmpty"

  /** Asserts that `arr` is empty (has length 0). */
  @inline
  let isEmpty = (~message=?, arr: array<'a>): unit => assertObj->isEmptyBinding(arr, ~message?)

  @send external isNotEmptyBinding: (t, 'a, ~message: string=?) => unit = "isNotEmpty"

  /** Asserts that `arr` is not empty. */
  @inline
  let isNotEmpty = (~message=?, arr: array<'a>): unit =>
    assertObj->isNotEmptyBinding(arr, ~message?)

  @send external lengthOfBinding: (t, 'a, int, ~message: string=?) => unit = "lengthOf"

  /** Asserts that `arr` has a `length` equal to `expected`. */
  @inline
  let lengthOf = (~message=?, arr: array<'a>, expected) =>
    assertObj->lengthOfBinding(arr, expected, ~message?)

  @send
  external includeBinding: (t, array<'a>, 'a, ~message: string=?) => unit = "include"

  /** Asserts that `haystack` array contains `needle`. */
  @inline
  let includes = (~message=?, haystack, needle) =>
    assertObj->includeBinding(haystack, needle, ~message?)

  @send
  external notIncludeBinding: (t, array<'a>, 'a, ~message: string=?) => unit = "notInclude"

  /** Asserts that `haystack` array does not contain `needle`. */
  @inline
  let notIncludes = (~message=?, haystack, needle) =>
    assertObj->notIncludeBinding(haystack, needle, ~message?)

  @send
  external sameMembersBinding: (t, array<'a>, array<'a>, ~message: string=?) => unit = "sameMembers"

  /** Asserts that `actual` and `expected` have the same members (in any order). */
  @inline
  let sameMembers = (~message=?, actual, expected) =>
    assertObj->sameMembersBinding(actual, expected, ~message?)

  @send
  external notSameMembersBinding: (t, array<'a>, array<'a>, ~message: string=?) => unit =
    "notSameMembers"

  /** Asserts that `actual` and `expected` do not have the same members. */
  @inline
  let notSameMembers = (~message=?, actual, expected) =>
    assertObj->notSameMembersBinding(actual, expected, ~message?)

  @send
  external sameDeepMembersBinding: (t, array<'a>, array<'a>, ~message: string=?) => unit =
    "sameDeepMembers"

  /** Asserts that `actual` and `expected` have the same members (deep comparison, any order). */
  @inline
  let sameDeepMembers = (~message=?, actual, expected) =>
    assertObj->sameDeepMembersBinding(actual, expected, ~message?)

  @send
  external notSameDeepMembersBinding: (t, array<'a>, array<'a>, ~message: string=?) => unit =
    "notSameDeepMembers"

  /** Asserts that `actual` and `expected` do not have the same members (deep comparison). */
  @inline
  let notSameDeepMembers = (~message=?, actual, expected) =>
    assertObj->notSameDeepMembersBinding(actual, expected, ~message?)

  @send
  external sameOrderedMembersBinding: (t, array<'a>, array<'a>, ~message: string=?) => unit =
    "sameOrderedMembers"

  /** Asserts that `actual` and `expected` have the same members in the same order. */
  @inline
  let sameOrderedMembers = (~message=?, actual, expected) =>
    assertObj->sameOrderedMembersBinding(actual, expected, ~message?)

  @send
  external notSameOrderedMembersBinding: (t, array<'a>, array<'a>, ~message: string=?) => unit =
    "notSameOrderedMembers"

  /** Asserts that `actual` and `expected` do not have the same members in order. */
  @inline
  let notSameOrderedMembers = (~message=?, actual, expected) =>
    assertObj->notSameOrderedMembersBinding(actual, expected, ~message?)

  @send
  external sameDeepOrderedMembersBinding: (t, array<'a>, array<'a>, ~message: string=?) => unit =
    "sameDeepOrderedMembers"

  /** Asserts that `actual` and `expected` have the same members in order (deep comparison). */
  @inline
  let sameDeepOrderedMembers = (~message=?, actual, expected) =>
    assertObj->sameDeepOrderedMembersBinding(actual, expected, ~message?)

  @send
  external notSameDeepOrderedMembersBinding: (t, array<'a>, array<'a>, ~message: string=?) => unit =
    "notSameDeepOrderedMembers"

  /** Asserts that `actual` and `expected` do not have the same members in order (deep comparison). */
  @inline
  let notSameDeepOrderedMembers = (~message=?, actual, expected) =>
    assertObj->notSameDeepOrderedMembersBinding(actual, expected, ~message?)

  @send
  external includeMembersBinding: (t, array<'a>, array<'a>, ~message: string=?) => unit =
    "includeMembers"

  /** Asserts that `superset` contains all members of `subset` (in any order). */
  @inline
  let includeMembers = (~message=?, superset, subset) =>
    assertObj->includeMembersBinding(superset, subset, ~message?)

  @send
  external notIncludeMembersBinding: (t, array<'a>, array<'a>, ~message: string=?) => unit =
    "notIncludeMembers"

  /** Asserts that `superset` does not contain all members of `subset`. */
  @inline
  let notIncludeMembers = (~message=?, superset, subset) =>
    assertObj->notIncludeMembersBinding(superset, subset, ~message?)

  @send
  external includeDeepMembersBinding: (t, array<'a>, array<'a>, ~message: string=?) => unit =
    "includeDeepMembers"

  /** Asserts that `superset` contains all members of `subset` (deep comparison). */
  @inline
  let includeDeepMembers = (~message=?, superset, subset) =>
    assertObj->includeDeepMembersBinding(superset, subset, ~message?)

  @send
  external notIncludeDeepMembersBinding: (t, array<'a>, array<'a>, ~message: string=?) => unit =
    "notIncludeDeepMembers"

  /** Asserts that `superset` does not contain all members of `subset` (deep comparison). */
  @inline
  let notIncludeDeepMembers = (~message=?, superset, subset) =>
    assertObj->notIncludeDeepMembersBinding(superset, subset, ~message?)

  @send
  external includeOrderedMembersBinding: (t, array<'a>, array<'a>, ~message: string=?) => unit =
    "includeOrderedMembers"

  /** Asserts that `superset` contains `subset` in the same order (as a contiguous subsequence). */
  @inline
  let includeOrderedMembers = (~message=?, superset, subset) =>
    assertObj->includeOrderedMembersBinding(superset, subset, ~message?)

  @send
  external notIncludeOrderedMembersBinding: (t, array<'a>, array<'a>, ~message: string=?) => unit =
    "notIncludeOrderedMembers"

  /** Asserts that `superset` does not contain `subset` as a contiguous subsequence. */
  @inline
  let notIncludeOrderedMembers = (~message=?, superset, subset) =>
    assertObj->notIncludeOrderedMembersBinding(superset, subset, ~message?)

  @send
  external includeDeepOrderedMembersBinding: (t, array<'a>, array<'a>, ~message: string=?) => unit =
    "includeDeepOrderedMembers"

  /** Asserts that `superset` contains `subset` in order (deep comparison). */
  @inline
  let includeDeepOrderedMembers = (~message=?, superset, subset) =>
    assertObj->includeDeepOrderedMembersBinding(superset, subset, ~message?)

  @send
  external notIncludeDeepOrderedMembersBinding: (
    t,
    array<'a>,
    array<'a>,
    ~message: string=?,
  ) => unit = "notIncludeDeepOrderedMembers"

  /** Asserts that `superset` does not contain `subset` in order (deep comparison). */
  @inline
  let notIncludeDeepOrderedMembers = (~message=?, superset, subset) =>
    assertObj->notIncludeDeepOrderedMembersBinding(superset, subset, ~message?)
}

// ============================================================================
// String Assertions
// ============================================================================

module String = {
  @send external isEmptyBinding: (t, 'a, ~message: string=?) => unit = "isEmpty"

  /** Asserts that `str` is empty (has length 0). */
  @inline
  let isEmpty = (~message=?, str: string): unit => assertObj->isEmptyBinding(str, ~message?)

  @send external isNotEmptyBinding: (t, 'a, ~message: string=?) => unit = "isNotEmpty"

  /** Asserts that `str` is not empty. */
  @inline
  let isNotEmpty = (~message=?, str: string): unit => assertObj->isNotEmptyBinding(str, ~message?)

  @send external lengthOfBinding: (t, 'a, int, ~message: string=?) => unit = "lengthOf"

  /** Asserts that `str` has a `length` equal to `expected`. */
  @inline
  let lengthOf = (~message=?, str: string, expected) =>
    assertObj->lengthOfBinding(str, expected, ~message?)

  @send
  external includeBinding: (t, string, string, ~message: string=?) => unit = "include"

  /** Asserts that `haystack` string contains `needle` substring. */
  @inline
  let includes = (~message=?, haystack, needle) =>
    assertObj->includeBinding(haystack, needle, ~message?)

  @send
  external notIncludeBinding: (t, string, string, ~message: string=?) => unit = "notInclude"

  /** Asserts that `haystack` string does not contain `needle` substring. */
  @inline
  let notIncludes = (~message=?, haystack, needle) =>
    assertObj->notIncludeBinding(haystack, needle, ~message?)
}

// ============================================================================
// Result Ergonomic Assertions
// ============================================================================

module Result = {
  /**
   * Asserts that `result` is `Ok`.
   */
  let isOk = (~message=?, result: result<'a, 'e>): unit => {
    switch result {
    | Ok(_) => ()
    | Error(_) =>
      let msg = message->Option.getOr("Expected Result to be Ok, but got Error")
      fail(~message=msg)
    }
  }

  /**
   * Asserts that `result` is `Error`.
   */
  let isError = (~message=?, result: result<'a, 'e>): unit => {
    switch result {
    | Error(_) => ()
    | Ok(_) =>
      let msg = message->Option.getOr("Expected Result to be Error, but got Ok")
      fail(~message=msg)
    }
  }
}

// ============================================================================
// Option Ergonomic Assertions
// ============================================================================

module Option = {
  /**
   * Asserts that `option` is `Some`.
   */
  let isSome = (~message=?, opt: option<'a>): unit => {
    switch opt {
    | Some(_) => ()
    | None =>
      let msg = message->Option.getOr("Expected Option to be Some, but got None")
      fail(~message=msg)
    }
  }

  /**
   * Asserts that `option` is `None`.
   */
  let isNone = (~message=?, opt: option<'a>): unit => {
    switch opt {
    | None => ()
    | Some(_) =>
      let msg = message->Option.getOr("Expected Option to be None, but got Some")
      fail(~message=msg)
    }
  }
}
