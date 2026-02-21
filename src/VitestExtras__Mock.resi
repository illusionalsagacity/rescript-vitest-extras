// VitestMock.resi - Strongly-typed bindings for Vitest's mocking API

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

/** Create a mock function with 0 arguments.
    Note: When called without implementation, will return undefined at runtime.
    For type safety, either:
    - Annotate the type: `let mock: mockFn0<int> = fn0()`
    - Use fnWithImpl0: `let mock = fnWithImpl0(() => 42)` */
let fn0: unit => mockFn0<'ret>

/** Create a mock function with an implementation: () => 'ret */
let fnWithImpl0: (unit => 'ret) => mockFn0<'ret>

/** Create a mock function with 1 argument.
    Note: When called without implementation, will return undefined at runtime. */
let fn1: unit => mockFn1<'a, 'ret>

/** Create a mock function with an implementation: 'a => 'ret */
let fnWithImpl1: ('a => 'ret) => mockFn1<'a, 'ret>

/** Create a mock function with 2 arguments.
    Note: When called without implementation, will return undefined at runtime. */
let fn2: unit => mockFn2<'a, 'b, 'ret>

/** Create a mock function with an implementation: ('a, 'b) => 'ret */
let fnWithImpl2: (('a, 'b) => 'ret) => mockFn2<'a, 'b, 'ret>

/** Create a mock function with 3 arguments.
    Note: When called without implementation, will return undefined at runtime. */
let fn3: unit => mockFn3<'a, 'b, 'c, 'ret>

/** Create a mock function with an implementation: ('a, 'b, 'c) => 'ret */
let fnWithImpl3: (('a, 'b, 'c) => 'ret) => mockFn3<'a, 'b, 'c, 'ret>

/** Create a mock function with 4 arguments.
    Note: When called without implementation, will return undefined at runtime. */
let fn4: unit => mockFn4<'a, 'b, 'c, 'd, 'ret>

/** Create a mock function with an implementation: ('a, 'b, 'c, 'd) => 'ret */
let fnWithImpl4: (('a, 'b, 'c, 'd) => 'ret) => mockFn4<'a, 'b, 'c, 'd, 'ret>

/** Create a mock function with 5 arguments.
    Note: When called without implementation, will return undefined at runtime. */
let fn5: unit => mockFn5<'a, 'b, 'c, 'd, 'e, 'ret>

/** Create a mock function with an implementation: ('a, 'b, 'c, 'd, 'e) => 'ret */
let fnWithImpl5: (('a, 'b, 'c, 'd, 'e) => 'ret) => mockFn5<'a, 'b, 'c, 'd, 'e, 'ret>

// =============================================================================
// Mock Instance Methods - mockFn0
// =============================================================================

module MockFn0: {
  /** Get the mock context containing calls, results, etc. */
  let mock: mockFn0<'ret> => mockContext0<'ret>

  /** Get the mock function name */
  let getMockName: mockFn0<'ret> => string

  /** Set the mock function name */
  let mockName: (mockFn0<'ret>, string) => mockFn0<'ret>

  /** Clear all information about every call */
  let mockClear: mockFn0<'ret> => mockFn0<'ret>

  /** Clear and reset to original implementation */
  let mockReset: mockFn0<'ret> => mockFn0<'ret>

  /** Restore original implementation (for spies) */
  let mockRestore: mockFn0<'ret> => unit

  /** Get current mock implementation */
  let getMockImplementation: mockFn0<'ret> => option<unit => 'ret>

  /** Set mock implementation */
  let mockImplementation: (mockFn0<'ret>, unit => 'ret) => mockFn0<'ret>

  /** Set mock implementation for next call only */
  let mockImplementationOnce: (mockFn0<'ret>, unit => 'ret) => mockFn0<'ret>

  /** Return `this` when called */
  let mockReturnThis: mockFn0<'ret> => mockFn0<'ret>

  /** Set return value for all calls */
  let mockReturnValue: (mockFn0<'ret>, 'ret) => mockFn0<'ret>

  /** Set return value for next call only */
  let mockReturnValueOnce: (mockFn0<'ret>, 'ret) => mockFn0<'ret>

  /** Set resolved value for async mock */
  let mockResolvedValue: (mockFn0<promise<'ret>>, 'ret) => mockFn0<promise<'ret>>

  /** Set resolved value for next async call only */
  let mockResolvedValueOnce: (mockFn0<promise<'ret>>, 'ret) => mockFn0<promise<'ret>>

  /** Set rejected value for async mock */
  let mockRejectedValue: (mockFn0<promise<'ret>>, unknown) => mockFn0<promise<'ret>>

  /** Set rejected value for next async call only */
  let mockRejectedValueOnce: (mockFn0<promise<'ret>>, unknown) => mockFn0<promise<'ret>>

  /** Convert to a callable function */
  let toFunction: mockFn0<'ret> => unit => 'ret
}

// =============================================================================
// Mock Instance Methods - mockFn1
// =============================================================================

module MockFn1: {
  let mock: mockFn1<'a, 'ret> => mockContext1<'a, 'ret>
  let getMockName: mockFn1<'a, 'ret> => string
  let mockName: (mockFn1<'a, 'ret>, string) => mockFn1<'a, 'ret>
  let mockClear: mockFn1<'a, 'ret> => mockFn1<'a, 'ret>
  let mockReset: mockFn1<'a, 'ret> => mockFn1<'a, 'ret>
  let mockRestore: mockFn1<'a, 'ret> => unit
  let getMockImplementation: mockFn1<'a, 'ret> => option<'a => 'ret>
  let mockImplementation: (mockFn1<'a, 'ret>, 'a => 'ret) => mockFn1<'a, 'ret>
  let mockImplementationOnce: (mockFn1<'a, 'ret>, 'a => 'ret) => mockFn1<'a, 'ret>
  let mockReturnThis: mockFn1<'a, 'ret> => mockFn1<'a, 'ret>
  let mockReturnValue: (mockFn1<'a, 'ret>, 'ret) => mockFn1<'a, 'ret>
  let mockReturnValueOnce: (mockFn1<'a, 'ret>, 'ret) => mockFn1<'a, 'ret>
  let mockResolvedValue: (mockFn1<'a, promise<'ret>>, 'ret) => mockFn1<'a, promise<'ret>>
  let mockResolvedValueOnce: (mockFn1<'a, promise<'ret>>, 'ret) => mockFn1<'a, promise<'ret>>
  let mockRejectedValue: (mockFn1<'a, promise<'ret>>, unknown) => mockFn1<'a, promise<'ret>>
  let mockRejectedValueOnce: (mockFn1<'a, promise<'ret>>, unknown) => mockFn1<'a, promise<'ret>>
  let toFunction: mockFn1<'a, 'ret> => 'a => 'ret
}

// =============================================================================
// Mock Instance Methods - mockFn2
// =============================================================================

module MockFn2: {
  let mock: mockFn2<'a, 'b, 'ret> => mockContext2<'a, 'b, 'ret>
  let getMockName: mockFn2<'a, 'b, 'ret> => string
  let mockName: (mockFn2<'a, 'b, 'ret>, string) => mockFn2<'a, 'b, 'ret>
  let mockClear: mockFn2<'a, 'b, 'ret> => mockFn2<'a, 'b, 'ret>
  let mockReset: mockFn2<'a, 'b, 'ret> => mockFn2<'a, 'b, 'ret>
  let mockRestore: mockFn2<'a, 'b, 'ret> => unit
  let getMockImplementation: mockFn2<'a, 'b, 'ret> => option<('a, 'b) => 'ret>
  let mockImplementation: (mockFn2<'a, 'b, 'ret>, ('a, 'b) => 'ret) => mockFn2<'a, 'b, 'ret>
  let mockImplementationOnce: (mockFn2<'a, 'b, 'ret>, ('a, 'b) => 'ret) => mockFn2<'a, 'b, 'ret>
  let mockReturnThis: mockFn2<'a, 'b, 'ret> => mockFn2<'a, 'b, 'ret>
  let mockReturnValue: (mockFn2<'a, 'b, 'ret>, 'ret) => mockFn2<'a, 'b, 'ret>
  let mockReturnValueOnce: (mockFn2<'a, 'b, 'ret>, 'ret) => mockFn2<'a, 'b, 'ret>
  let mockResolvedValue: (mockFn2<'a, 'b, promise<'ret>>, 'ret) => mockFn2<'a, 'b, promise<'ret>>
  let mockResolvedValueOnce: (
    mockFn2<'a, 'b, promise<'ret>>,
    'ret,
  ) => mockFn2<'a, 'b, promise<'ret>>
  let mockRejectedValue: (mockFn2<'a, 'b, promise<'ret>>, unknown) => mockFn2<'a, 'b, promise<'ret>>
  let mockRejectedValueOnce: (
    mockFn2<'a, 'b, promise<'ret>>,
    unknown,
  ) => mockFn2<'a, 'b, promise<'ret>>
  let toFunction: mockFn2<'a, 'b, 'ret> => ('a, 'b) => 'ret
}

// =============================================================================
// Mock Instance Methods - mockFn3
// =============================================================================

module MockFn3: {
  let mock: mockFn3<'a, 'b, 'c, 'ret> => mockContext3<'a, 'b, 'c, 'ret>
  let getMockName: mockFn3<'a, 'b, 'c, 'ret> => string
  let mockName: (mockFn3<'a, 'b, 'c, 'ret>, string) => mockFn3<'a, 'b, 'c, 'ret>
  let mockClear: mockFn3<'a, 'b, 'c, 'ret> => mockFn3<'a, 'b, 'c, 'ret>
  let mockReset: mockFn3<'a, 'b, 'c, 'ret> => mockFn3<'a, 'b, 'c, 'ret>
  let mockRestore: mockFn3<'a, 'b, 'c, 'ret> => unit
  let getMockImplementation: mockFn3<'a, 'b, 'c, 'ret> => option<('a, 'b, 'c) => 'ret>
  let mockImplementation: (
    mockFn3<'a, 'b, 'c, 'ret>,
    ('a, 'b, 'c) => 'ret,
  ) => mockFn3<'a, 'b, 'c, 'ret>
  let mockImplementationOnce: (
    mockFn3<'a, 'b, 'c, 'ret>,
    ('a, 'b, 'c) => 'ret,
  ) => mockFn3<'a, 'b, 'c, 'ret>
  let mockReturnThis: mockFn3<'a, 'b, 'c, 'ret> => mockFn3<'a, 'b, 'c, 'ret>
  let mockReturnValue: (mockFn3<'a, 'b, 'c, 'ret>, 'ret) => mockFn3<'a, 'b, 'c, 'ret>
  let mockReturnValueOnce: (mockFn3<'a, 'b, 'c, 'ret>, 'ret) => mockFn3<'a, 'b, 'c, 'ret>
  let mockResolvedValue: (
    mockFn3<'a, 'b, 'c, promise<'ret>>,
    'ret,
  ) => mockFn3<'a, 'b, 'c, promise<'ret>>
  let mockResolvedValueOnce: (
    mockFn3<'a, 'b, 'c, promise<'ret>>,
    'ret,
  ) => mockFn3<'a, 'b, 'c, promise<'ret>>
  let mockRejectedValue: (
    mockFn3<'a, 'b, 'c, promise<'ret>>,
    unknown,
  ) => mockFn3<'a, 'b, 'c, promise<'ret>>
  let mockRejectedValueOnce: (
    mockFn3<'a, 'b, 'c, promise<'ret>>,
    unknown,
  ) => mockFn3<'a, 'b, 'c, promise<'ret>>
  let toFunction: mockFn3<'a, 'b, 'c, 'ret> => ('a, 'b, 'c) => 'ret
}

// =============================================================================
// Mock Instance Methods - mockFn4
// =============================================================================

module MockFn4: {
  let mock: mockFn4<'a, 'b, 'c, 'd, 'ret> => mockContext4<'a, 'b, 'c, 'd, 'ret>
  let getMockName: mockFn4<'a, 'b, 'c, 'd, 'ret> => string
  let mockName: (mockFn4<'a, 'b, 'c, 'd, 'ret>, string) => mockFn4<'a, 'b, 'c, 'd, 'ret>
  let mockClear: mockFn4<'a, 'b, 'c, 'd, 'ret> => mockFn4<'a, 'b, 'c, 'd, 'ret>
  let mockReset: mockFn4<'a, 'b, 'c, 'd, 'ret> => mockFn4<'a, 'b, 'c, 'd, 'ret>
  let mockRestore: mockFn4<'a, 'b, 'c, 'd, 'ret> => unit
  let getMockImplementation: mockFn4<'a, 'b, 'c, 'd, 'ret> => option<('a, 'b, 'c, 'd) => 'ret>
  let mockImplementation: (
    mockFn4<'a, 'b, 'c, 'd, 'ret>,
    ('a, 'b, 'c, 'd) => 'ret,
  ) => mockFn4<'a, 'b, 'c, 'd, 'ret>
  let mockImplementationOnce: (
    mockFn4<'a, 'b, 'c, 'd, 'ret>,
    ('a, 'b, 'c, 'd) => 'ret,
  ) => mockFn4<'a, 'b, 'c, 'd, 'ret>
  let mockReturnThis: mockFn4<'a, 'b, 'c, 'd, 'ret> => mockFn4<'a, 'b, 'c, 'd, 'ret>
  let mockReturnValue: (mockFn4<'a, 'b, 'c, 'd, 'ret>, 'ret) => mockFn4<'a, 'b, 'c, 'd, 'ret>
  let mockReturnValueOnce: (mockFn4<'a, 'b, 'c, 'd, 'ret>, 'ret) => mockFn4<'a, 'b, 'c, 'd, 'ret>
  let mockResolvedValue: (
    mockFn4<'a, 'b, 'c, 'd, promise<'ret>>,
    'ret,
  ) => mockFn4<'a, 'b, 'c, 'd, promise<'ret>>
  let mockResolvedValueOnce: (
    mockFn4<'a, 'b, 'c, 'd, promise<'ret>>,
    'ret,
  ) => mockFn4<'a, 'b, 'c, 'd, promise<'ret>>
  let mockRejectedValue: (
    mockFn4<'a, 'b, 'c, 'd, promise<'ret>>,
    unknown,
  ) => mockFn4<'a, 'b, 'c, 'd, promise<'ret>>
  let mockRejectedValueOnce: (
    mockFn4<'a, 'b, 'c, 'd, promise<'ret>>,
    unknown,
  ) => mockFn4<'a, 'b, 'c, 'd, promise<'ret>>
  let toFunction: mockFn4<'a, 'b, 'c, 'd, 'ret> => ('a, 'b, 'c, 'd) => 'ret
}

// =============================================================================
// Mock Instance Methods - mockFn5
// =============================================================================

module MockFn5: {
  let mock: mockFn5<'a, 'b, 'c, 'd, 'e, 'ret> => mockContext5<'a, 'b, 'c, 'd, 'e, 'ret>
  let getMockName: mockFn5<'a, 'b, 'c, 'd, 'e, 'ret> => string
  let mockName: (mockFn5<'a, 'b, 'c, 'd, 'e, 'ret>, string) => mockFn5<'a, 'b, 'c, 'd, 'e, 'ret>
  let mockClear: mockFn5<'a, 'b, 'c, 'd, 'e, 'ret> => mockFn5<'a, 'b, 'c, 'd, 'e, 'ret>
  let mockReset: mockFn5<'a, 'b, 'c, 'd, 'e, 'ret> => mockFn5<'a, 'b, 'c, 'd, 'e, 'ret>
  let mockRestore: mockFn5<'a, 'b, 'c, 'd, 'e, 'ret> => unit
  let getMockImplementation: mockFn5<'a, 'b, 'c, 'd, 'e, 'ret> => option<
    ('a, 'b, 'c, 'd, 'e) => 'ret,
  >
  let mockImplementation: (
    mockFn5<'a, 'b, 'c, 'd, 'e, 'ret>,
    ('a, 'b, 'c, 'd, 'e) => 'ret,
  ) => mockFn5<'a, 'b, 'c, 'd, 'e, 'ret>
  let mockImplementationOnce: (
    mockFn5<'a, 'b, 'c, 'd, 'e, 'ret>,
    ('a, 'b, 'c, 'd, 'e) => 'ret,
  ) => mockFn5<'a, 'b, 'c, 'd, 'e, 'ret>
  let mockReturnThis: mockFn5<'a, 'b, 'c, 'd, 'e, 'ret> => mockFn5<'a, 'b, 'c, 'd, 'e, 'ret>
  let mockReturnValue: (
    mockFn5<'a, 'b, 'c, 'd, 'e, 'ret>,
    'ret,
  ) => mockFn5<'a, 'b, 'c, 'd, 'e, 'ret>
  let mockReturnValueOnce: (
    mockFn5<'a, 'b, 'c, 'd, 'e, 'ret>,
    'ret,
  ) => mockFn5<'a, 'b, 'c, 'd, 'e, 'ret>
  let mockResolvedValue: (
    mockFn5<'a, 'b, 'c, 'd, 'e, promise<'ret>>,
    'ret,
  ) => mockFn5<'a, 'b, 'c, 'd, 'e, promise<'ret>>
  let mockResolvedValueOnce: (
    mockFn5<'a, 'b, 'c, 'd, 'e, promise<'ret>>,
    'ret,
  ) => mockFn5<'a, 'b, 'c, 'd, 'e, promise<'ret>>
  let mockRejectedValue: (
    mockFn5<'a, 'b, 'c, 'd, 'e, promise<'ret>>,
    unknown,
  ) => mockFn5<'a, 'b, 'c, 'd, 'e, promise<'ret>>
  let mockRejectedValueOnce: (
    mockFn5<'a, 'b, 'c, 'd, 'e, promise<'ret>>,
    unknown,
  ) => mockFn5<'a, 'b, 'c, 'd, 'e, promise<'ret>>
  let toFunction: mockFn5<'a, 'b, 'c, 'd, 'e, 'ret> => ('a, 'b, 'c, 'd, 'e) => 'ret
}

// =============================================================================
// vi.clearAllMocks, vi.resetAllMocks, vi.restoreAllMocks
// =============================================================================

let clearAllMocks: unit => Vitest.Vi.t
let resetAllMocks: unit => Vitest.Vi.t
let restoreAllMocks: unit => Vitest.Vi.t

// =============================================================================
// vi.isMockFunction
// =============================================================================

let isMockFunction: 'a => bool
