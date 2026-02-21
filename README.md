# rescript-vitest-extras

Additional ReScript bindings for [Vitest](https://vitest.dev/), extending [rescript-vitest](https://github.com/cometkim/rescript-vitest).

## Installation

```bash
npm install rescript-vitest-extras rescript-vitest vitest
# or
yarn add rescript-vitest-extras rescript-vitest vitest
```

Add to your `rescript.json`:

```json
{
  "dependencies": ["rescript-vitest", "rescript-vitest-extras"]
}
```

## Modules

### VitestExtras.Assert

Chai-style assert API bindings with ReScript-specific assertions for `option`, `result`, `Null.t`, `Nullable.t`, and `undefined`.

```rescript
open Vitest
module A = VitestExtras.Assert

test("equality", _ => {
  A.equal(1, 1)
  A.deepEqual([1, 2, 3], [1, 2, 3])
})

test("option assertions", _ => {
  A.Option.isSome(Some(42))
  A.Option.isNone(None)
})

test("result assertions", _ => {
  A.Result.isOk(Ok(42))
  A.Result.isError(Error("fail"))
})

test("nullable assertions", _ => {
  let value: Nullable.t<int> = Nullable.make(42)
  A.Nullable.exists(value)
  A.Nullable.isNotNull(value)
})

test("array assertions", _ => {
  A.Array.includes([1, 2, 3], 2)
  A.Array.sameMembers([1, 2, 3], [3, 1, 2])
  A.Array.lengthOf([1, 2], 2)
})

test("string assertions", _ => {
  A.String.includes("hello world", "world")
  A.String.isEmpty("")
})

test("numeric comparisons", _ => {
  A.isAbove(10.0, 5.0)
  A.closeTo(1.5, 1.0, ~delta=1.0)
})

test("exceptions", _ => {
  A.throws(() => JsError.throwWithMessage("error"))
  A.doesNotThrow(() => ())
})
```

All assertions accept an optional `~message` parameter for custom failure messages.

### VitestExtras.Mock

Arity-specific mock function types with full access to mock context, implementation control, and return value stubbing.

```rescript
open Vitest
open VitestExtras

module M = Mock

describe("mock functions", () => {
  test("create and call mocks", _ => {
    // Create with implementation
    let add = M.fnWithImpl2((a, b) => a + b)
    let fn = add->M.MockFn2.toFunction

    A.equal(fn(2, 3), 5)
  })

  test("stub return values", _ => {
    let mock = M.fn0()->M.MockFn0.mockReturnValue(42)
    let fn = mock->M.MockFn0.toFunction

    A.equal(fn(), 42)
  })

  test("access call history", _ => {
    let mock = M.fnWithImpl1(x => x * 2)
    let fn = mock->M.MockFn1.toFunction

    let _ = fn(5)
    let _ = fn(10)

    let ctx = mock->M.MockFn1.mock
    A.Array.lengthOf(ctx.calls, 2)
  })

  test("mock implementation once", _ => {
    let mock = M.fn0()
      ->M.MockFn0.mockReturnValueOnce(1)
      ->M.MockFn0.mockReturnValueOnce(2)
      ->M.MockFn0.mockReturnValue(999)
    let fn = mock->M.MockFn0.toFunction

    A.equal(fn(), 1)
    A.equal(fn(), 2)
    A.equal(fn(), 999)
  })

  test("async mocks", async () => {
    let mock = M.fn0()->M.MockFn0.mockResolvedValue(42)
    let fn = mock->M.MockFn0.toFunction

    let result = await fn()
    A.equal(result, 42)
  })
})
```

Available arities: `mockFn0` through `mockFn5`, each with corresponding `MockFn0` through `MockFn5` modules.

### VitestExtras.MockExpect

Expect matchers for mock function assertions.

```rescript
open Vitest
open VitestExtras

module M = Mock
module ME = MockExpect

test("mock matchers", _ => {
  let mock = M.fnWithImpl1(x => x + 1)
  let fn = mock->M.MockFn1.toFunction

  let _ = fn(5)

  expect(mock)->ME.toHaveBeenCalled
  expect(mock)->ME.toHaveBeenCalledTimes(1)
  expect(mock)->ME.toHaveBeenCalledWith1(5)
  expect(mock)->ME.toHaveReturnedWith(6)
})
```

## Module Organization

This library uses the `VitestExtras__` namespace for internal modules with a public `VitestExtras` entry point that exports all public APIs. You can access modules in two ways:

**Recommended** — via the public `VitestExtras` entry point:
```rescript
open VitestExtras
module A = Assert
module M = Mock
```

**Alternatively** — use fully qualified internal names:
```rescript
module A = VitestExtras__Assert
module M = VitestExtras__Mock
```

## Mock Function Types

| Type                                | Signature                      |
| ----------------------------------- | ------------------------------ |
| `mockFn0<'ret>`                     | `() => 'ret`                   |
| `mockFn1<'a, 'ret>`                 | `'a => 'ret`                   |
| `mockFn2<'a, 'b, 'ret>`             | `('a, 'b) => 'ret`             |
| `mockFn3<'a, 'b, 'c, 'ret>`         | `('a, 'b, 'c) => 'ret`         |
| `mockFn4<'a, 'b, 'c, 'd, 'ret>`     | `('a, 'b, 'c, 'd) => 'ret`     |
| `mockFn5<'a, 'b, 'c, 'd, 'e, 'ret>` | `('a, 'b, 'c, 'd, 'e) => 'ret` |
