// VitestMockExpect.res - Expect matchers for mock functions
//
// These matchers work with Vitest's expect() function for asserting on mock behavior.
// Provides arity-specific variants for type-safe argument checking.

open Vitest_Types

// =============================================================================
// Base Mock Matchers (no argument checking)
// =============================================================================

/** Asserts that the mock function was called at least once */
@send external toHaveBeenCalled: assertion<'mock> => unit = "toHaveBeenCalled"

/** Asserts that the mock function was called exactly once */
@send external toHaveBeenCalledOnce: assertion<'mock> => unit = "toHaveBeenCalledOnce"

/** Alias for toHaveBeenCalled */
@send external toBeCalled: assertion<'mock> => unit = "toBeCalled"

/** Asserts that the mock function was called exactly n times */
@send external toHaveBeenCalledTimes: (assertion<'mock>, int) => unit = "toHaveBeenCalledTimes"

/** Alias for toHaveBeenCalledTimes */
@send external toBeCalledTimes: (assertion<'mock>, int) => unit = "toBeCalledTimes"

// =============================================================================
// toHaveBeenCalledWith - Arity Variants
// =============================================================================

/** Asserts the mock was called with no arguments */
@send external toHaveBeenCalledWith0: assertion<VitestMock.mockFn0<'ret>> => unit = "toHaveBeenCalledWith"

/** Asserts the mock was called with 1 argument */
@send
external toHaveBeenCalledWith1: (assertion<VitestMock.mockFn1<'a, 'ret>>, 'a) => unit =
  "toHaveBeenCalledWith"

/** Asserts the mock was called with 2 arguments */
@send
external toHaveBeenCalledWith2: (assertion<VitestMock.mockFn2<'a, 'b, 'ret>>, 'a, 'b) => unit =
  "toHaveBeenCalledWith"

/** Asserts the mock was called with 3 arguments */
@send
external toHaveBeenCalledWith3: (
  assertion<VitestMock.mockFn3<'a, 'b, 'c, 'ret>>,
  'a,
  'b,
  'c,
) => unit = "toHaveBeenCalledWith"

/** Asserts the mock was called with 4 arguments */
@send
external toHaveBeenCalledWith4: (
  assertion<VitestMock.mockFn4<'a, 'b, 'c, 'd, 'ret>>,
  'a,
  'b,
  'c,
  'd,
) => unit = "toHaveBeenCalledWith"

/** Asserts the mock was called with 5 arguments */
@send
external toHaveBeenCalledWith5: (
  assertion<VitestMock.mockFn5<'a, 'b, 'c, 'd, 'e, 'ret>>,
  'a,
  'b,
  'c,
  'd,
  'e,
) => unit = "toHaveBeenCalledWith"

// Aliases
@send external toBeCalledWith0: assertion<VitestMock.mockFn0<'ret>> => unit = "toBeCalledWith"

@send
external toBeCalledWith1: (assertion<VitestMock.mockFn1<'a, 'ret>>, 'a) => unit = "toBeCalledWith"

@send
external toBeCalledWith2: (assertion<VitestMock.mockFn2<'a, 'b, 'ret>>, 'a, 'b) => unit =
  "toBeCalledWith"

@send
external toBeCalledWith3: (assertion<VitestMock.mockFn3<'a, 'b, 'c, 'ret>>, 'a, 'b, 'c) => unit =
  "toBeCalledWith"

@send
external toBeCalledWith4: (
  assertion<VitestMock.mockFn4<'a, 'b, 'c, 'd, 'ret>>,
  'a,
  'b,
  'c,
  'd,
) => unit = "toBeCalledWith"

@send
external toBeCalledWith5: (
  assertion<VitestMock.mockFn5<'a, 'b, 'c, 'd, 'e, 'ret>>,
  'a,
  'b,
  'c,
  'd,
  'e,
) => unit = "toBeCalledWith"

// =============================================================================
// toHaveBeenCalledExactlyOnceWith - Arity Variants
// =============================================================================

/** Asserts the mock was called exactly once with no arguments */
@send
external toHaveBeenCalledExactlyOnceWith0: assertion<VitestMock.mockFn0<'ret>> => unit =
  "toHaveBeenCalledExactlyOnceWith"

/** Asserts the mock was called exactly once with 1 argument */
@send
external toHaveBeenCalledExactlyOnceWith1: (
  assertion<VitestMock.mockFn1<'a, 'ret>>,
  'a,
) => unit = "toHaveBeenCalledExactlyOnceWith"

/** Asserts the mock was called exactly once with 2 arguments */
@send
external toHaveBeenCalledExactlyOnceWith2: (
  assertion<VitestMock.mockFn2<'a, 'b, 'ret>>,
  'a,
  'b,
) => unit = "toHaveBeenCalledExactlyOnceWith"

/** Asserts the mock was called exactly once with 3 arguments */
@send
external toHaveBeenCalledExactlyOnceWith3: (
  assertion<VitestMock.mockFn3<'a, 'b, 'c, 'ret>>,
  'a,
  'b,
  'c,
) => unit = "toHaveBeenCalledExactlyOnceWith"

/** Asserts the mock was called exactly once with 4 arguments */
@send
external toHaveBeenCalledExactlyOnceWith4: (
  assertion<VitestMock.mockFn4<'a, 'b, 'c, 'd, 'ret>>,
  'a,
  'b,
  'c,
  'd,
) => unit = "toHaveBeenCalledExactlyOnceWith"

/** Asserts the mock was called exactly once with 5 arguments */
@send
external toHaveBeenCalledExactlyOnceWith5: (
  assertion<VitestMock.mockFn5<'a, 'b, 'c, 'd, 'e, 'ret>>,
  'a,
  'b,
  'c,
  'd,
  'e,
) => unit = "toHaveBeenCalledExactlyOnceWith"

// =============================================================================
// toHaveBeenLastCalledWith - Arity Variants
// =============================================================================

/** Asserts the mock's last call had no arguments */
@send
external toHaveBeenLastCalledWith0: assertion<VitestMock.mockFn0<'ret>> => unit =
  "toHaveBeenLastCalledWith"

/** Asserts the mock's last call had 1 argument */
@send
external toHaveBeenLastCalledWith1: (assertion<VitestMock.mockFn1<'a, 'ret>>, 'a) => unit =
  "toHaveBeenLastCalledWith"

/** Asserts the mock's last call had 2 arguments */
@send
external toHaveBeenLastCalledWith2: (
  assertion<VitestMock.mockFn2<'a, 'b, 'ret>>,
  'a,
  'b,
) => unit = "toHaveBeenLastCalledWith"

/** Asserts the mock's last call had 3 arguments */
@send
external toHaveBeenLastCalledWith3: (
  assertion<VitestMock.mockFn3<'a, 'b, 'c, 'ret>>,
  'a,
  'b,
  'c,
) => unit = "toHaveBeenLastCalledWith"

/** Asserts the mock's last call had 4 arguments */
@send
external toHaveBeenLastCalledWith4: (
  assertion<VitestMock.mockFn4<'a, 'b, 'c, 'd, 'ret>>,
  'a,
  'b,
  'c,
  'd,
) => unit = "toHaveBeenLastCalledWith"

/** Asserts the mock's last call had 5 arguments */
@send
external toHaveBeenLastCalledWith5: (
  assertion<VitestMock.mockFn5<'a, 'b, 'c, 'd, 'e, 'ret>>,
  'a,
  'b,
  'c,
  'd,
  'e,
) => unit = "toHaveBeenLastCalledWith"

// Aliases
@send
external lastCalledWith0: assertion<VitestMock.mockFn0<'ret>> => unit = "lastCalledWith"

@send
external lastCalledWith1: (assertion<VitestMock.mockFn1<'a, 'ret>>, 'a) => unit = "lastCalledWith"

@send
external lastCalledWith2: (assertion<VitestMock.mockFn2<'a, 'b, 'ret>>, 'a, 'b) => unit =
  "lastCalledWith"

@send
external lastCalledWith3: (assertion<VitestMock.mockFn3<'a, 'b, 'c, 'ret>>, 'a, 'b, 'c) => unit =
  "lastCalledWith"

@send
external lastCalledWith4: (
  assertion<VitestMock.mockFn4<'a, 'b, 'c, 'd, 'ret>>,
  'a,
  'b,
  'c,
  'd,
) => unit = "lastCalledWith"

@send
external lastCalledWith5: (
  assertion<VitestMock.mockFn5<'a, 'b, 'c, 'd, 'e, 'ret>>,
  'a,
  'b,
  'c,
  'd,
  'e,
) => unit = "lastCalledWith"

// =============================================================================
// toHaveBeenNthCalledWith - Arity Variants
// =============================================================================

/** Asserts the nth call had no arguments */
@send
external toHaveBeenNthCalledWith0: (assertion<VitestMock.mockFn0<'ret>>, int) => unit =
  "toHaveBeenNthCalledWith"

/** Asserts the nth call had 1 argument */
@send
external toHaveBeenNthCalledWith1: (
  assertion<VitestMock.mockFn1<'a, 'ret>>,
  int,
  'a,
) => unit = "toHaveBeenNthCalledWith"

/** Asserts the nth call had 2 arguments */
@send
external toHaveBeenNthCalledWith2: (
  assertion<VitestMock.mockFn2<'a, 'b, 'ret>>,
  int,
  'a,
  'b,
) => unit = "toHaveBeenNthCalledWith"

/** Asserts the nth call had 3 arguments */
@send
external toHaveBeenNthCalledWith3: (
  assertion<VitestMock.mockFn3<'a, 'b, 'c, 'ret>>,
  int,
  'a,
  'b,
  'c,
) => unit = "toHaveBeenNthCalledWith"

/** Asserts the nth call had 4 arguments */
@send
external toHaveBeenNthCalledWith4: (
  assertion<VitestMock.mockFn4<'a, 'b, 'c, 'd, 'ret>>,
  int,
  'a,
  'b,
  'c,
  'd,
) => unit = "toHaveBeenNthCalledWith"

/** Asserts the nth call had 5 arguments */
@send
external toHaveBeenNthCalledWith5: (
  assertion<VitestMock.mockFn5<'a, 'b, 'c, 'd, 'e, 'ret>>,
  int,
  'a,
  'b,
  'c,
  'd,
  'e,
) => unit = "toHaveBeenNthCalledWith"

// Aliases
@send
external nthCalledWith0: (assertion<VitestMock.mockFn0<'ret>>, int) => unit = "nthCalledWith"

@send
external nthCalledWith1: (assertion<VitestMock.mockFn1<'a, 'ret>>, int, 'a) => unit =
  "nthCalledWith"

@send
external nthCalledWith2: (assertion<VitestMock.mockFn2<'a, 'b, 'ret>>, int, 'a, 'b) => unit =
  "nthCalledWith"

@send
external nthCalledWith3: (
  assertion<VitestMock.mockFn3<'a, 'b, 'c, 'ret>>,
  int,
  'a,
  'b,
  'c,
) => unit = "nthCalledWith"

@send
external nthCalledWith4: (
  assertion<VitestMock.mockFn4<'a, 'b, 'c, 'd, 'ret>>,
  int,
  'a,
  'b,
  'c,
  'd,
) => unit = "nthCalledWith"

@send
external nthCalledWith5: (
  assertion<VitestMock.mockFn5<'a, 'b, 'c, 'd, 'e, 'ret>>,
  int,
  'a,
  'b,
  'c,
  'd,
  'e,
) => unit = "nthCalledWith"

// =============================================================================
// Return Value Matchers
// =============================================================================

/** Asserts the mock returned successfully at least once (didn't throw) */
@send external toHaveReturned: assertion<'mock> => unit = "toHaveReturned"

/** Alias for toHaveReturned */
@send external toReturn: assertion<'mock> => unit = "toReturn"

/** Asserts the mock returned successfully exactly n times */
@send external toHaveReturnedTimes: (assertion<'mock>, int) => unit = "toHaveReturnedTimes"

/** Alias for toHaveReturnedTimes */
@send external toReturnTimes: (assertion<'mock>, int) => unit = "toReturnTimes"

/** Asserts the mock returned a specific value */
@send external toHaveReturnedWith: (assertion<'mock>, 'ret) => unit = "toHaveReturnedWith"

/** Alias for toHaveReturnedWith */
@send external toReturnWith: (assertion<'mock>, 'ret) => unit = "toReturnWith"

/** Asserts the mock's last return value */
@send external toHaveLastReturnedWith: (assertion<'mock>, 'ret) => unit = "toHaveLastReturnedWith"

/** Alias for toHaveLastReturnedWith */
@send external lastReturnedWith: (assertion<'mock>, 'ret) => unit = "lastReturnedWith"

/** Asserts the nth call returned a specific value */
@send
external toHaveNthReturnedWith: (assertion<'mock>, int, 'ret) => unit = "toHaveNthReturnedWith"

/** Alias for toHaveNthReturnedWith */
@send external nthReturnedWith: (assertion<'mock>, int, 'ret) => unit = "nthReturnedWith"

// =============================================================================
// Call Order Matchers
// =============================================================================

/** Type for any MockInstance (used in call order matchers) */
type anyMockInstance

/** Convert any mock function to anyMockInstance for call order comparison */
external toAnyMockInstance: 'mock => anyMockInstance = "%identity"

/** Asserts this mock was called before another mock */
@send
external toHaveBeenCalledBefore: (
  assertion<'mock>,
  anyMockInstance,
  ~failIfNoFirstInvocation: bool=?,
) => unit = "toHaveBeenCalledBefore"

/** Asserts this mock was called after another mock */
@send
external toHaveBeenCalledAfter: (
  assertion<'mock>,
  anyMockInstance,
  ~failIfNoFirstInvocation: bool=?,
) => unit = "toHaveBeenCalledAfter"

// =============================================================================
// Negation Support
// =============================================================================

/** Get the negated assertion for mock matchers */
@get external not: assertion<'mock> => assertion<'mock> = "not"

// =============================================================================
// Promise/Async Resolution Matchers
// =============================================================================

/** Asserts an async mock resolved at least once */
@send external toHaveResolved: assertion<'mock> => unit = "toHaveResolved"

/** Asserts an async mock resolved with a specific value */
@send external toHaveResolvedWith: (assertion<'mock>, 'ret) => unit = "toHaveResolvedWith"

/** Asserts an async mock resolved exactly n times */
@send external toHaveResolvedTimes: (assertion<'mock>, int) => unit = "toHaveResolvedTimes"

/** Asserts the last resolved value of an async mock */
@send
external toHaveLastResolvedWith: (assertion<'mock>, 'ret) => unit = "toHaveLastResolvedWith"

/** Asserts the nth resolved value of an async mock */
@send
external toHaveNthResolvedWith: (assertion<'mock>, int, 'ret) => unit = "toHaveNthResolvedWith"
