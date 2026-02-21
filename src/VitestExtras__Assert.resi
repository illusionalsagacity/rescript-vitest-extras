/**
 * Vitest Assert API bindings.
 *
 * These bindings wrap Vitest's chai-based assert API with ergonomic ReScript types.
 * Organized into submodules for type-specific assertions.
 */
/** Asserts that `expression` is truthy. */
let // ============================================================================
// Core Assertions
// ============================================================================

assert_: (~message: string=?, 'a) => unit

/** Force an assertion failure with an optional message. */
let fail: (~message: string=?) => unit

// ============================================================================
// Equality
// ============================================================================

/** Non-strict equality comparison (==). */
let equal: (~message: string=?, 'a, 'a) => unit

/** Non-strict inequality comparison (!=). */
let notEqual: (~message: string=?, 'a, 'a) => unit

/** Strict equality comparison (===). */
let strictEqual: (~message: string=?, 'a, 'a) => unit

/** Strict inequality comparison (!==). */
let notStrictEqual: (~message: string=?, 'a, 'a) => unit

/** Deep equality comparison. */
let deepEqual: (~message: string=?, 'a, 'a) => unit

/** Deep inequality comparison. */
let notDeepEqual: (~message: string=?, 'a, 'a) => unit

// ============================================================================
// Numeric Comparisons
// ============================================================================

/** Asserts that `value > target`. */
let isAbove: (~message: string=?, float, float) => unit

/** Asserts that `value >= target`. */
let isAtLeast: (~message: string=?, float, float) => unit

/** Asserts that `value < target`. */
let isBelow: (~message: string=?, float, float) => unit

/** Asserts that `value <= target`. */
let isAtMost: (~message: string=?, float, float) => unit

/** Asserts that `actual` is within +/- `delta` of `expected`. */
let closeTo: (~message: string=?, float, float, ~delta: float) => unit

/** Alias for `closeTo`. */
let approximately: (~message: string=?, float, float, ~delta: float) => unit

// ============================================================================
// Boolean Assertions
// ============================================================================

/** Asserts that `value` is exactly `true`. */
let isTrue: (~message: string=?, bool) => unit

/** Asserts that `value` is not exactly `true`. */
let isNotTrue: (~message: string=?, bool) => unit

/** Asserts that `value` is exactly `false`. */
let isFalse: (~message: string=?, bool) => unit

/** Asserts that `value` is not exactly `false`. */
let isNotFalse: (~message: string=?, bool) => unit

// ============================================================================
// NaN and Finite Assertions
// ============================================================================

/** Asserts that `value` is `NaN`. */
let isNaN: (~message: string=?, float) => unit

/** Asserts that `value` is not `NaN`. */
let isNotNaN: (~message: string=?, float) => unit

/** Asserts that `value` is finite (not NaN or Infinity). */
let isFinite: (~message: string=?, float) => unit

// ============================================================================
// Regex Matching
// ============================================================================

/** Asserts that `value` matches the regular expression. */
let match_: (~message: string=?, string, RegExp.t) => unit

/** Asserts that `value` does not match the regular expression. */
let notMatch: (~message: string=?, string, RegExp.t) => unit

// ============================================================================
// oneOf
// ============================================================================

/** Asserts that `value` is one of the values in `list`. */
let oneOf: (~message: string=?, 'a, array<'a>) => unit

// ============================================================================
// Exception Assertions
// ============================================================================

/** Asserts that `fn` throws an exception. */
let throws: (~message: string=?, unit => 'a) => unit

/** Asserts that `fn` throws an exception matching the regexp. */
let throwsWithMatch: (~message: string=?, unit => 'a, RegExp.t) => unit

/** Asserts that `fn` does not throw an exception. */
let doesNotThrow: (~message: string=?, unit => 'a) => unit

// ============================================================================
// Object State Assertions
// ============================================================================

/** Asserts that `object` is extensible (can have new properties added). */
let isExtensible: (~message: string=?, 'a) => unit

/** Asserts that `object` is not extensible. */
let isNotExtensible: (~message: string=?, 'a) => unit

/** Asserts that `object` is sealed (properties cannot be added or deleted). */
let isSealed: (~message: string=?, 'a) => unit

/** Asserts that `object` is not sealed. */
let isNotSealed: (~message: string=?, 'a) => unit

/** Asserts that `object` is frozen (cannot be modified at all). */
let isFrozen: (~message: string=?, 'a) => unit

/** Asserts that `object` is not frozen. */
let isNotFrozen: (~message: string=?, 'a) => unit

// ============================================================================
// Null Assertions
// ============================================================================

module Null: {
  /** Asserts that `value` is `null`. */
  let isNull: (~message: string=?, Null.t<'a>) => unit

  /** Asserts that `value` is not `null`. */
  let isNotNull: (~message: string=?, Null.t<'a>) => unit
}

// ============================================================================
// Undefined Assertions
// ============================================================================

module Undefined: {
  /** Asserts that `value` is `undefined`. */
  let isUndefined: (~message: string=?, undefined<'a>) => unit

  /** Asserts that `value` is not `undefined`. */
  let isDefined: (~message: string=?, undefined<'a>) => unit
}

// ============================================================================
// Nullable Assertions (null | undefined | value)
// ============================================================================

module Nullable: {
  /** Asserts that `value` is `null`. */
  let isNull: (~message: string=?, Nullable.t<'a>) => unit

  /** Asserts that `value` is not `null` (may still be undefined). */
  let isNotNull: (~message: string=?, Nullable.t<'a>) => unit

  /** Asserts that `value` is `undefined`. */
  let isUndefined: (~message: string=?, Nullable.t<'a>) => unit

  /** Asserts that `value` is not `undefined` (may still be null). */
  let isDefined: (~message: string=?, Nullable.t<'a>) => unit

  /** Asserts that `value` is neither `null` nor `undefined`. */
  let exists: (~message: string=?, Nullable.t<'a>) => unit

  /** Asserts that `value` is `null` or `undefined`. */
  let notExists: (~message: string=?, Nullable.t<'a>) => unit
}

// ============================================================================
// Array Assertions
// ============================================================================

module Array: {
  /** Asserts that `arr` is empty (has length 0). */
  let isEmpty: (~message: string=?, array<'a>) => unit

  /** Asserts that `arr` is not empty. */
  let isNotEmpty: (~message: string=?, array<'a>) => unit

  /** Asserts that `arr` has a `length` equal to `expected`. */
  let lengthOf: (~message: string=?, array<'a>, int) => unit

  /** Asserts that `haystack` array contains `needle`. */
  let includes: (~message: string=?, array<'a>, 'a) => unit

  /** Asserts that `haystack` array does not contain `needle`. */
  let notIncludes: (~message: string=?, array<'a>, 'a) => unit

  /** Asserts that `actual` and `expected` have the same members (in any order). */
  let sameMembers: (~message: string=?, array<'a>, array<'a>) => unit

  /** Asserts that `actual` and `expected` do not have the same members. */
  let notSameMembers: (~message: string=?, array<'a>, array<'a>) => unit

  /** Asserts that `actual` and `expected` have the same members (deep comparison, any order). */
  let sameDeepMembers: (~message: string=?, array<'a>, array<'a>) => unit

  /** Asserts that `actual` and `expected` do not have the same members (deep comparison). */
  let notSameDeepMembers: (~message: string=?, array<'a>, array<'a>) => unit

  /** Asserts that `actual` and `expected` have the same members in the same order. */
  let sameOrderedMembers: (~message: string=?, array<'a>, array<'a>) => unit

  /** Asserts that `actual` and `expected` do not have the same members in order. */
  let notSameOrderedMembers: (~message: string=?, array<'a>, array<'a>) => unit

  /** Asserts that `actual` and `expected` have the same members in order (deep comparison). */
  let sameDeepOrderedMembers: (~message: string=?, array<'a>, array<'a>) => unit

  /** Asserts that `actual` and `expected` do not have the same members in order (deep comparison). */
  let notSameDeepOrderedMembers: (~message: string=?, array<'a>, array<'a>) => unit

  /** Asserts that `superset` contains all members of `subset` (in any order). */
  let includeMembers: (~message: string=?, array<'a>, array<'a>) => unit

  /** Asserts that `superset` does not contain all members of `subset`. */
  let notIncludeMembers: (~message: string=?, array<'a>, array<'a>) => unit

  /** Asserts that `superset` contains all members of `subset` (deep comparison). */
  let includeDeepMembers: (~message: string=?, array<'a>, array<'a>) => unit

  /** Asserts that `superset` does not contain all members of `subset` (deep comparison). */
  let notIncludeDeepMembers: (~message: string=?, array<'a>, array<'a>) => unit

  /** Asserts that `superset` contains `subset` in the same order (as a contiguous subsequence). */
  let includeOrderedMembers: (~message: string=?, array<'a>, array<'a>) => unit

  /** Asserts that `superset` does not contain `subset` as a contiguous subsequence. */
  let notIncludeOrderedMembers: (~message: string=?, array<'a>, array<'a>) => unit

  /** Asserts that `superset` contains `subset` in order (deep comparison). */
  let includeDeepOrderedMembers: (~message: string=?, array<'a>, array<'a>) => unit

  /** Asserts that `superset` does not contain `subset` in order (deep comparison). */
  let notIncludeDeepOrderedMembers: (~message: string=?, array<'a>, array<'a>) => unit
}

// ============================================================================
// String Assertions
// ============================================================================

module String: {
  /** Asserts that `str` is empty (has length 0). */
  let isEmpty: (~message: string=?, string) => unit

  /** Asserts that `str` is not empty. */
  let isNotEmpty: (~message: string=?, string) => unit

  /** Asserts that `str` has a `length` equal to `expected`. */
  let lengthOf: (~message: string=?, string, int) => unit

  /** Asserts that `haystack` string contains `needle` substring. */
  let includes: (~message: string=?, string, string) => unit

  /** Asserts that `haystack` string does not contain `needle` substring. */
  let notIncludes: (~message: string=?, string, string) => unit
}

// ============================================================================
// Result Ergonomic Assertions
// ============================================================================

module Result: {
  /** Asserts that `result` is `Ok`. */
  let isOk: (~message: string=?, result<'a, 'e>) => unit

  /** Asserts that `result` is `Error`. */
  let isError: (~message: string=?, result<'a, 'e>) => unit
}

// ============================================================================
// Option Ergonomic Assertions
// ============================================================================

module Option: {
  /** Asserts that `option` is `Some`. */
  let isSome: (~message: string=?, option<'a>) => unit

  /** Asserts that `option` is `None`. */
  let isNone: (~message: string=?, option<'a>) => unit
}
