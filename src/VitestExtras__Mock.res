// VitestMock.res - Strongly-typed bindings for Vitest's mocking API
//
// Design notes:
// - Separate types per arity (mockFn0, mockFn1, etc.) for type safety
// - Mock functions are callable via external bindings
// - Uses @unboxed variants for mock result types (zero-cost)

// =============================================================================
// Mock Result Types
// =============================================================================

/** Type of a mock result - discriminator field */
type mockResultType = [#return | #incomplete | #throw]

/** Result of a single mock function invocation.
    Use `type_` to discriminate:
    - #return: successful return, `value` contains the return value
    - #incomplete: function hasn't returned yet
    - #throw: function threw an error, `value` contains the error */
type mockResult<'ret> = {
  @as("type") type_: mockResultType,
  value: 'ret,
}

/** Type of a settled result - discriminator field */
type mockSettledResultType = [#fulfilled | #rejected]

/** Settled result for async mock functions.
    Use `type_` to discriminate:
    - #fulfilled: promise resolved, `value` contains the resolved value
    - #rejected: promise rejected, `value` contains the rejection reason */
type mockSettledResult<'ret> = {
  @as("type") type_: mockSettledResultType,
  value: 'ret,
}

// =============================================================================
// Mock Context Types (per arity)
// =============================================================================

/** Context for 0-arity mock functions */
type mockContext0<'ret> = {
  calls: array<unit>,
  instances: array<'ret>,
  contexts: array<unknown>,
  invocationCallOrder: array<int>,
  results: array<mockResult<'ret>>,
  settledResults: array<mockSettledResult<'ret>>,
  lastCall: option<unit>,
}

/** Context for 1-arity mock functions.
    Note: calls and lastCall use array<'a> because Vitest stores
    single-argument calls as [arg] arrays */
type mockContext1<'a, 'ret> = {
  calls: array<array<'a>>,
  instances: array<'ret>,
  contexts: array<unknown>,
  invocationCallOrder: array<int>,
  results: array<mockResult<'ret>>,
  settledResults: array<mockSettledResult<'ret>>,
  lastCall: option<array<'a>>,
}

/** Context for 2-arity mock functions */
type mockContext2<'a, 'b, 'ret> = {
  calls: array<('a, 'b)>,
  instances: array<'ret>,
  contexts: array<unknown>,
  invocationCallOrder: array<int>,
  results: array<mockResult<'ret>>,
  settledResults: array<mockSettledResult<'ret>>,
  lastCall: option<('a, 'b)>,
}

/** Context for 3-arity mock functions */
type mockContext3<'a, 'b, 'c, 'ret> = {
  calls: array<('a, 'b, 'c)>,
  instances: array<'ret>,
  contexts: array<unknown>,
  invocationCallOrder: array<int>,
  results: array<mockResult<'ret>>,
  settledResults: array<mockSettledResult<'ret>>,
  lastCall: option<('a, 'b, 'c)>,
}

/** Context for 4-arity mock functions */
type mockContext4<'a, 'b, 'c, 'd, 'ret> = {
  calls: array<('a, 'b, 'c, 'd)>,
  instances: array<'ret>,
  contexts: array<unknown>,
  invocationCallOrder: array<int>,
  results: array<mockResult<'ret>>,
  settledResults: array<mockSettledResult<'ret>>,
  lastCall: option<('a, 'b, 'c, 'd)>,
}

/** Context for 5-arity mock functions */
type mockContext5<'a, 'b, 'c, 'd, 'e, 'ret> = {
  calls: array<('a, 'b, 'c, 'd, 'e)>,
  instances: array<'ret>,
  contexts: array<unknown>,
  invocationCallOrder: array<int>,
  results: array<mockResult<'ret>>,
  settledResults: array<mockSettledResult<'ret>>,
  lastCall: option<('a, 'b, 'c, 'd, 'e)>,
}

// =============================================================================
// Mock Function Types (per arity)
// =============================================================================

/** Mock function with 0 arguments: () => 'ret */
type mockFn0<'ret>

/** Mock function with 1 argument: 'a => 'ret */
type mockFn1<'a, 'ret>

/** Mock function with 2 arguments: ('a, 'b) => 'ret */
type mockFn2<'a, 'b, 'ret>

/** Mock function with 3 arguments: ('a, 'b, 'c) => 'ret */
type mockFn3<'a, 'b, 'c, 'ret>

/** Mock function with 4 arguments: ('a, 'b, 'c, 'd) => 'ret */
type mockFn4<'a, 'b, 'c, 'd, 'ret>

/** Mock function with 5 arguments: ('a, 'b, 'c, 'd, 'e) => 'ret */
type mockFn5<'a, 'b, 'c, 'd, 'e, 'ret>

// =============================================================================
// vi.fn() - Create Mock Functions
// =============================================================================

@module("vitest") @val external vi: Vitest.Vi.t = "vi"

/** Create a mock function with 0 arguments.
    Note: When called without implementation, will return undefined at runtime.
    For type safety, either:
    - Annotate the type: `let mock: mockFn0<int> = fn0()`
    - Use fnWithImpl0: `let mock = fnWithImpl0(() => 42)` */
@send external fn0: Vitest.Vi.t => mockFn0<'ret> = "fn"

/** Create a mock function with an implementation: () => 'ret */
@send
external fnWithImpl0: (Vitest.Vi.t, unit => 'ret) => mockFn0<'ret> = "fn"

/** Create a mock function with 1 argument.
    Note: When called without implementation, will return undefined at runtime. */
@send external fn1: Vitest.Vi.t => mockFn1<'a, 'ret> = "fn"

/** Create a mock function with an implementation: 'a => 'ret */
@send
external fnWithImpl1: (Vitest.Vi.t, 'a => 'ret) => mockFn1<'a, 'ret> = "fn"

/** Create a mock function with 2 arguments.
    Note: When called without implementation, will return undefined at runtime. */
@send external fn2: Vitest.Vi.t => mockFn2<'a, 'b, 'ret> = "fn"

/** Create a mock function with an implementation: ('a, 'b) => 'ret */
@send
external fnWithImpl2: (Vitest.Vi.t, ('a, 'b) => 'ret) => mockFn2<'a, 'b, 'ret> = "fn"

/** Create a mock function with 3 arguments.
    Note: When called without implementation, will return undefined at runtime. */
@send external fn3: Vitest.Vi.t => mockFn3<'a, 'b, 'c, 'ret> = "fn"

/** Create a mock function with an implementation: ('a, 'b, 'c) => 'ret */
@send
external fnWithImpl3: (Vitest.Vi.t, ('a, 'b, 'c) => 'ret) => mockFn3<'a, 'b, 'c, 'ret> = "fn"

/** Create a mock function with 4 arguments.
    Note: When called without implementation, will return undefined at runtime. */
@send external fn4: Vitest.Vi.t => mockFn4<'a, 'b, 'c, 'd, 'ret> = "fn"

/** Create a mock function with an implementation: ('a, 'b, 'c, 'd) => 'ret */
@send
external fnWithImpl4: (Vitest.Vi.t, ('a, 'b, 'c, 'd) => 'ret) => mockFn4<'a, 'b, 'c, 'd, 'ret> =
  "fn"

/** Create a mock function with 5 arguments.
    Note: When called without implementation, will return undefined at runtime. */
@send external fn5: Vitest.Vi.t => mockFn5<'a, 'b, 'c, 'd, 'e, 'ret> = "fn"

/** Create a mock function with an implementation: ('a, 'b, 'c, 'd, 'e) => 'ret */
@send
external fnWithImpl5: (
  Vitest.Vi.t,
  ('a, 'b, 'c, 'd, 'e) => 'ret,
) => mockFn5<'a, 'b, 'c, 'd, 'e, 'ret> = "fn"

// Convenience functions that don't require passing vi
let fn0 = () => vi->fn0
let fnWithImpl0 = impl => vi->fnWithImpl0(impl)
let fn1 = () => vi->fn1
let fnWithImpl1 = impl => vi->fnWithImpl1(impl)
let fn2 = () => vi->fn2
let fnWithImpl2 = impl => vi->fnWithImpl2(impl)
let fn3 = () => vi->fn3
let fnWithImpl3 = impl => vi->fnWithImpl3(impl)
let fn4 = () => vi->fn4
let fnWithImpl4 = impl => vi->fnWithImpl4(impl)
let fn5 = () => vi->fn5
let fnWithImpl5 = impl => vi->fnWithImpl5(impl)

// =============================================================================
// Mock Instance Methods - mockFn0
// =============================================================================

module MockFn0 = {
  /** Get the mock context containing calls, results, etc. */
  @get external mock: mockFn0<'ret> => mockContext0<'ret> = "mock"

  /** Get the mock function name */
  @send external getMockName: mockFn0<'ret> => string = "getMockName"

  /** Set the mock function name */
  @send external mockName: (mockFn0<'ret>, string) => mockFn0<'ret> = "mockName"

  /** Clear all information about every call */
  @send external mockClear: mockFn0<'ret> => mockFn0<'ret> = "mockClear"

  /** Clear and reset to original implementation */
  @send external mockReset: mockFn0<'ret> => mockFn0<'ret> = "mockReset"

  /** Restore original implementation (for spies) */
  @send external mockRestore: mockFn0<'ret> => unit = "mockRestore"

  /** Get current mock implementation */
  @send @return(nullable)
  external getMockImplementation: mockFn0<'ret> => option<unit => 'ret> = "getMockImplementation"

  /** Set mock implementation */
  @send
  external mockImplementation: (mockFn0<'ret>, unit => 'ret) => mockFn0<'ret> = "mockImplementation"

  /** Set mock implementation for next call only */
  @send
  external mockImplementationOnce: (mockFn0<'ret>, unit => 'ret) => mockFn0<'ret> =
    "mockImplementationOnce"

  /** Return `this` when called */
  @send external mockReturnThis: mockFn0<'ret> => mockFn0<'ret> = "mockReturnThis"

  /** Set return value for all calls */
  @send
  external mockReturnValue: (mockFn0<'ret>, 'ret) => mockFn0<'ret> = "mockReturnValue"

  /** Set return value for next call only */
  @send
  external mockReturnValueOnce: (mockFn0<'ret>, 'ret) => mockFn0<'ret> = "mockReturnValueOnce"

  /** Set resolved value for async mock */
  @send
  external mockResolvedValue: (mockFn0<promise<'ret>>, 'ret) => mockFn0<promise<'ret>> =
    "mockResolvedValue"

  /** Set resolved value for next async call only */
  @send
  external mockResolvedValueOnce: (mockFn0<promise<'ret>>, 'ret) => mockFn0<promise<'ret>> =
    "mockResolvedValueOnce"

  /** Set rejected value for async mock */
  @send
  external mockRejectedValue: (mockFn0<promise<'ret>>, unknown) => mockFn0<promise<'ret>> =
    "mockRejectedValue"

  /** Set rejected value for next async call only */
  @send
  external mockRejectedValueOnce: (mockFn0<promise<'ret>>, unknown) => mockFn0<promise<'ret>> =
    "mockRejectedValueOnce"

  /** Convert to a callable function */
  external toFunction: mockFn0<'ret> => unit => 'ret = "%identity"
}

// =============================================================================
// Mock Instance Methods - mockFn1
// =============================================================================

module MockFn1 = {
  @get external mock: mockFn1<'a, 'ret> => mockContext1<'a, 'ret> = "mock"
  @send external getMockName: mockFn1<'a, 'ret> => string = "getMockName"
  @send external mockName: (mockFn1<'a, 'ret>, string) => mockFn1<'a, 'ret> = "mockName"
  @send external mockClear: mockFn1<'a, 'ret> => mockFn1<'a, 'ret> = "mockClear"
  @send external mockReset: mockFn1<'a, 'ret> => mockFn1<'a, 'ret> = "mockReset"
  @send external mockRestore: mockFn1<'a, 'ret> => unit = "mockRestore"

  @send @return(nullable)
  external getMockImplementation: mockFn1<'a, 'ret> => option<'a => 'ret> = "getMockImplementation"

  @send
  external mockImplementation: (mockFn1<'a, 'ret>, 'a => 'ret) => mockFn1<'a, 'ret> =
    "mockImplementation"

  @send
  external mockImplementationOnce: (mockFn1<'a, 'ret>, 'a => 'ret) => mockFn1<'a, 'ret> =
    "mockImplementationOnce"

  @send external mockReturnThis: mockFn1<'a, 'ret> => mockFn1<'a, 'ret> = "mockReturnThis"

  @send
  external mockReturnValue: (mockFn1<'a, 'ret>, 'ret) => mockFn1<'a, 'ret> = "mockReturnValue"

  @send
  external mockReturnValueOnce: (mockFn1<'a, 'ret>, 'ret) => mockFn1<'a, 'ret> =
    "mockReturnValueOnce"

  @send
  external mockResolvedValue: (mockFn1<'a, promise<'ret>>, 'ret) => mockFn1<'a, promise<'ret>> =
    "mockResolvedValue"

  @send
  external mockResolvedValueOnce: (mockFn1<'a, promise<'ret>>, 'ret) => mockFn1<'a, promise<'ret>> =
    "mockResolvedValueOnce"

  @send
  external mockRejectedValue: (mockFn1<'a, promise<'ret>>, unknown) => mockFn1<'a, promise<'ret>> =
    "mockRejectedValue"

  @send
  external mockRejectedValueOnce: (
    mockFn1<'a, promise<'ret>>,
    unknown,
  ) => mockFn1<'a, promise<'ret>> = "mockRejectedValueOnce"

  external toFunction: mockFn1<'a, 'ret> => 'a => 'ret = "%identity"
}

// =============================================================================
// Mock Instance Methods - mockFn2
// =============================================================================

module MockFn2 = {
  @get external mock: mockFn2<'a, 'b, 'ret> => mockContext2<'a, 'b, 'ret> = "mock"
  @send external getMockName: mockFn2<'a, 'b, 'ret> => string = "getMockName"
  @send
  external mockName: (mockFn2<'a, 'b, 'ret>, string) => mockFn2<'a, 'b, 'ret> = "mockName"
  @send external mockClear: mockFn2<'a, 'b, 'ret> => mockFn2<'a, 'b, 'ret> = "mockClear"
  @send external mockReset: mockFn2<'a, 'b, 'ret> => mockFn2<'a, 'b, 'ret> = "mockReset"
  @send external mockRestore: mockFn2<'a, 'b, 'ret> => unit = "mockRestore"

  @send @return(nullable)
  external getMockImplementation: mockFn2<'a, 'b, 'ret> => option<('a, 'b) => 'ret> =
    "getMockImplementation"

  @send
  external mockImplementation: (mockFn2<'a, 'b, 'ret>, ('a, 'b) => 'ret) => mockFn2<'a, 'b, 'ret> =
    "mockImplementation"

  @send
  external mockImplementationOnce: (
    mockFn2<'a, 'b, 'ret>,
    ('a, 'b) => 'ret,
  ) => mockFn2<'a, 'b, 'ret> = "mockImplementationOnce"

  @send
  external mockReturnThis: mockFn2<'a, 'b, 'ret> => mockFn2<'a, 'b, 'ret> = "mockReturnThis"

  @send
  external mockReturnValue: (mockFn2<'a, 'b, 'ret>, 'ret) => mockFn2<'a, 'b, 'ret> =
    "mockReturnValue"

  @send
  external mockReturnValueOnce: (mockFn2<'a, 'b, 'ret>, 'ret) => mockFn2<'a, 'b, 'ret> =
    "mockReturnValueOnce"

  @send
  external mockResolvedValue: (
    mockFn2<'a, 'b, promise<'ret>>,
    'ret,
  ) => mockFn2<'a, 'b, promise<'ret>> = "mockResolvedValue"

  @send
  external mockResolvedValueOnce: (
    mockFn2<'a, 'b, promise<'ret>>,
    'ret,
  ) => mockFn2<'a, 'b, promise<'ret>> = "mockResolvedValueOnce"

  @send
  external mockRejectedValue: (
    mockFn2<'a, 'b, promise<'ret>>,
    unknown,
  ) => mockFn2<'a, 'b, promise<'ret>> = "mockRejectedValue"

  @send
  external mockRejectedValueOnce: (
    mockFn2<'a, 'b, promise<'ret>>,
    unknown,
  ) => mockFn2<'a, 'b, promise<'ret>> = "mockRejectedValueOnce"

  external toFunction: mockFn2<'a, 'b, 'ret> => ('a, 'b) => 'ret = "%identity"
}

// =============================================================================
// Mock Instance Methods - mockFn3
// =============================================================================

module MockFn3 = {
  @get external mock: mockFn3<'a, 'b, 'c, 'ret> => mockContext3<'a, 'b, 'c, 'ret> = "mock"
  @send external getMockName: mockFn3<'a, 'b, 'c, 'ret> => string = "getMockName"
  @send
  external mockName: (mockFn3<'a, 'b, 'c, 'ret>, string) => mockFn3<'a, 'b, 'c, 'ret> = "mockName"
  @send
  external mockClear: mockFn3<'a, 'b, 'c, 'ret> => mockFn3<'a, 'b, 'c, 'ret> = "mockClear"
  @send
  external mockReset: mockFn3<'a, 'b, 'c, 'ret> => mockFn3<'a, 'b, 'c, 'ret> = "mockReset"
  @send external mockRestore: mockFn3<'a, 'b, 'c, 'ret> => unit = "mockRestore"

  @send @return(nullable)
  external getMockImplementation: mockFn3<'a, 'b, 'c, 'ret> => option<('a, 'b, 'c) => 'ret> =
    "getMockImplementation"

  @send
  external mockImplementation: (
    mockFn3<'a, 'b, 'c, 'ret>,
    ('a, 'b, 'c) => 'ret,
  ) => mockFn3<'a, 'b, 'c, 'ret> = "mockImplementation"

  @send
  external mockImplementationOnce: (
    mockFn3<'a, 'b, 'c, 'ret>,
    ('a, 'b, 'c) => 'ret,
  ) => mockFn3<'a, 'b, 'c, 'ret> = "mockImplementationOnce"

  @send
  external mockReturnThis: mockFn3<'a, 'b, 'c, 'ret> => mockFn3<'a, 'b, 'c, 'ret> = "mockReturnThis"

  @send
  external mockReturnValue: (mockFn3<'a, 'b, 'c, 'ret>, 'ret) => mockFn3<'a, 'b, 'c, 'ret> =
    "mockReturnValue"

  @send
  external mockReturnValueOnce: (mockFn3<'a, 'b, 'c, 'ret>, 'ret) => mockFn3<'a, 'b, 'c, 'ret> =
    "mockReturnValueOnce"

  @send
  external mockResolvedValue: (
    mockFn3<'a, 'b, 'c, promise<'ret>>,
    'ret,
  ) => mockFn3<'a, 'b, 'c, promise<'ret>> = "mockResolvedValue"

  @send
  external mockResolvedValueOnce: (
    mockFn3<'a, 'b, 'c, promise<'ret>>,
    'ret,
  ) => mockFn3<'a, 'b, 'c, promise<'ret>> = "mockResolvedValueOnce"

  @send
  external mockRejectedValue: (
    mockFn3<'a, 'b, 'c, promise<'ret>>,
    unknown,
  ) => mockFn3<'a, 'b, 'c, promise<'ret>> = "mockRejectedValue"

  @send
  external mockRejectedValueOnce: (
    mockFn3<'a, 'b, 'c, promise<'ret>>,
    unknown,
  ) => mockFn3<'a, 'b, 'c, promise<'ret>> = "mockRejectedValueOnce"

  external toFunction: mockFn3<'a, 'b, 'c, 'ret> => ('a, 'b, 'c) => 'ret = "%identity"
}

// =============================================================================
// Mock Instance Methods - mockFn4
// =============================================================================

module MockFn4 = {
  @get
  external mock: mockFn4<'a, 'b, 'c, 'd, 'ret> => mockContext4<'a, 'b, 'c, 'd, 'ret> = "mock"
  @send external getMockName: mockFn4<'a, 'b, 'c, 'd, 'ret> => string = "getMockName"
  @send
  external mockName: (mockFn4<'a, 'b, 'c, 'd, 'ret>, string) => mockFn4<'a, 'b, 'c, 'd, 'ret> =
    "mockName"
  @send
  external mockClear: mockFn4<'a, 'b, 'c, 'd, 'ret> => mockFn4<'a, 'b, 'c, 'd, 'ret> = "mockClear"
  @send
  external mockReset: mockFn4<'a, 'b, 'c, 'd, 'ret> => mockFn4<'a, 'b, 'c, 'd, 'ret> = "mockReset"
  @send external mockRestore: mockFn4<'a, 'b, 'c, 'd, 'ret> => unit = "mockRestore"

  @send @return(nullable)
  external getMockImplementation: mockFn4<'a, 'b, 'c, 'd, 'ret> => option<
    ('a, 'b, 'c, 'd) => 'ret,
  > = "getMockImplementation"

  @send
  external mockImplementation: (
    mockFn4<'a, 'b, 'c, 'd, 'ret>,
    ('a, 'b, 'c, 'd) => 'ret,
  ) => mockFn4<'a, 'b, 'c, 'd, 'ret> = "mockImplementation"

  @send
  external mockImplementationOnce: (
    mockFn4<'a, 'b, 'c, 'd, 'ret>,
    ('a, 'b, 'c, 'd) => 'ret,
  ) => mockFn4<'a, 'b, 'c, 'd, 'ret> = "mockImplementationOnce"

  @send
  external mockReturnThis: mockFn4<'a, 'b, 'c, 'd, 'ret> => mockFn4<'a, 'b, 'c, 'd, 'ret> =
    "mockReturnThis"

  @send
  external mockReturnValue: (mockFn4<'a, 'b, 'c, 'd, 'ret>, 'ret) => mockFn4<'a, 'b, 'c, 'd, 'ret> =
    "mockReturnValue"

  @send
  external mockReturnValueOnce: (
    mockFn4<'a, 'b, 'c, 'd, 'ret>,
    'ret,
  ) => mockFn4<'a, 'b, 'c, 'd, 'ret> = "mockReturnValueOnce"

  @send
  external mockResolvedValue: (
    mockFn4<'a, 'b, 'c, 'd, promise<'ret>>,
    'ret,
  ) => mockFn4<'a, 'b, 'c, 'd, promise<'ret>> = "mockResolvedValue"

  @send
  external mockResolvedValueOnce: (
    mockFn4<'a, 'b, 'c, 'd, promise<'ret>>,
    'ret,
  ) => mockFn4<'a, 'b, 'c, 'd, promise<'ret>> = "mockResolvedValueOnce"

  @send
  external mockRejectedValue: (
    mockFn4<'a, 'b, 'c, 'd, promise<'ret>>,
    unknown,
  ) => mockFn4<'a, 'b, 'c, 'd, promise<'ret>> = "mockRejectedValue"

  @send
  external mockRejectedValueOnce: (
    mockFn4<'a, 'b, 'c, 'd, promise<'ret>>,
    unknown,
  ) => mockFn4<'a, 'b, 'c, 'd, promise<'ret>> = "mockRejectedValueOnce"

  external toFunction: mockFn4<'a, 'b, 'c, 'd, 'ret> => ('a, 'b, 'c, 'd) => 'ret = "%identity"
}

// =============================================================================
// Mock Instance Methods - mockFn5
// =============================================================================

module MockFn5 = {
  @get
  external mock: mockFn5<'a, 'b, 'c, 'd, 'e, 'ret> => mockContext5<'a, 'b, 'c, 'd, 'e, 'ret> =
    "mock"
  @send external getMockName: mockFn5<'a, 'b, 'c, 'd, 'e, 'ret> => string = "getMockName"
  @send
  external mockName: (
    mockFn5<'a, 'b, 'c, 'd, 'e, 'ret>,
    string,
  ) => mockFn5<'a, 'b, 'c, 'd, 'e, 'ret> = "mockName"
  @send
  external mockClear: mockFn5<'a, 'b, 'c, 'd, 'e, 'ret> => mockFn5<'a, 'b, 'c, 'd, 'e, 'ret> =
    "mockClear"
  @send
  external mockReset: mockFn5<'a, 'b, 'c, 'd, 'e, 'ret> => mockFn5<'a, 'b, 'c, 'd, 'e, 'ret> =
    "mockReset"
  @send external mockRestore: mockFn5<'a, 'b, 'c, 'd, 'e, 'ret> => unit = "mockRestore"

  @send @return(nullable)
  external getMockImplementation: mockFn5<'a, 'b, 'c, 'd, 'e, 'ret> => option<
    ('a, 'b, 'c, 'd, 'e) => 'ret,
  > = "getMockImplementation"

  @send
  external mockImplementation: (
    mockFn5<'a, 'b, 'c, 'd, 'e, 'ret>,
    ('a, 'b, 'c, 'd, 'e) => 'ret,
  ) => mockFn5<'a, 'b, 'c, 'd, 'e, 'ret> = "mockImplementation"

  @send
  external mockImplementationOnce: (
    mockFn5<'a, 'b, 'c, 'd, 'e, 'ret>,
    ('a, 'b, 'c, 'd, 'e) => 'ret,
  ) => mockFn5<'a, 'b, 'c, 'd, 'e, 'ret> = "mockImplementationOnce"

  @send
  external mockReturnThis: mockFn5<'a, 'b, 'c, 'd, 'e, 'ret> => mockFn5<'a, 'b, 'c, 'd, 'e, 'ret> =
    "mockReturnThis"

  @send
  external mockReturnValue: (
    mockFn5<'a, 'b, 'c, 'd, 'e, 'ret>,
    'ret,
  ) => mockFn5<'a, 'b, 'c, 'd, 'e, 'ret> = "mockReturnValue"

  @send
  external mockReturnValueOnce: (
    mockFn5<'a, 'b, 'c, 'd, 'e, 'ret>,
    'ret,
  ) => mockFn5<'a, 'b, 'c, 'd, 'e, 'ret> = "mockReturnValueOnce"

  @send
  external mockResolvedValue: (
    mockFn5<'a, 'b, 'c, 'd, 'e, promise<'ret>>,
    'ret,
  ) => mockFn5<'a, 'b, 'c, 'd, 'e, promise<'ret>> = "mockResolvedValue"

  @send
  external mockResolvedValueOnce: (
    mockFn5<'a, 'b, 'c, 'd, 'e, promise<'ret>>,
    'ret,
  ) => mockFn5<'a, 'b, 'c, 'd, 'e, promise<'ret>> = "mockResolvedValueOnce"

  @send
  external mockRejectedValue: (
    mockFn5<'a, 'b, 'c, 'd, 'e, promise<'ret>>,
    unknown,
  ) => mockFn5<'a, 'b, 'c, 'd, 'e, promise<'ret>> = "mockRejectedValue"

  @send
  external mockRejectedValueOnce: (
    mockFn5<'a, 'b, 'c, 'd, 'e, promise<'ret>>,
    unknown,
  ) => mockFn5<'a, 'b, 'c, 'd, 'e, promise<'ret>> = "mockRejectedValueOnce"

  external toFunction: mockFn5<'a, 'b, 'c, 'd, 'e, 'ret> => ('a, 'b, 'c, 'd, 'e) => 'ret =
    "%identity"
}

// =============================================================================
// vi.clearAllMocks, vi.resetAllMocks, vi.restoreAllMocks
// =============================================================================

@send external clearAllMocks: Vitest.Vi.t => Vitest.Vi.t = "clearAllMocks"
@send external resetAllMocks: Vitest.Vi.t => Vitest.Vi.t = "resetAllMocks"
@send external restoreAllMocks: Vitest.Vi.t => Vitest.Vi.t = "restoreAllMocks"

@inline let clearAllMocks = () => vi->clearAllMocks
@inline let resetAllMocks = () => vi->resetAllMocks
@inline let restoreAllMocks = () => vi->restoreAllMocks

// =============================================================================
// vi.isMockFunction
// =============================================================================

@send external isMockFunction: (Vitest.Vi.t, 'a) => bool = "isMockFunction"
@inline let isMockFunction = fn => vi->isMockFunction(fn)
