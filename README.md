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

## Browser Mode

Bindings for [Vitest Browser Mode](https://vitest.dev/guide/browser/), including page queries, locator interactions, user events, DOM assertions, and React component rendering via `vitest-browser-react`.

The browser mode modules are:

| Module             | Description                                                                     |
| ------------------ | ------------------------------------------------------------------------------- |
| `BrowserPage`      | Page-level queries (`getByRole`, `getByText`, etc.), viewport, and screenshots  |
| `BrowserLocator`   | Locator chaining, filtering, interactions (`click`, `fill`), and element access |
| `BrowserUserEvent` | User interaction simulation (`click`, `type_`, `keyboard`, `hover`, clipboard)  |
| `BrowserExpect`    | DOM assertions via `expect.element()` with automatic retry                      |
| `BrowserReact`     | React component rendering and hook testing via `vitest-browser-react`           |

### Rendering a component and asserting on its output

```rescript
open Vitest
open VitestExtras

describe("Counter", () => {
  testAsync("renders Counter with buttons and count text", async _ => {
    let screen = await BrowserReact.render(<Counter.Counter />)

    let incrementBtn = screen->BrowserReact.getByRole(
      "button",
      ~options={name: BrowserLocator.String("Increment")},
    )
    let countText = screen->BrowserReact.getByText(BrowserLocator.String("Count: 0"))

    await BrowserExpect.element(incrementBtn)->BrowserExpect.toBeVisible
    await BrowserExpect.element(incrementBtn)->BrowserExpect.toBeEnabled
    await BrowserExpect.element(countText)->BrowserExpect.toHaveTextContent(
      BrowserLocator.String("Count: 0"),
    )
  })
})
```

### Form interaction and user events

```rescript
testAsync("fills input, submits, and asserts result", async _ => {
  let screen = await BrowserReact.render(<TodoInput.TodoInput />)

  let input = screen->BrowserReact.getByPlaceholder(BrowserLocator.String("Enter a todo..."))
  let addBtn = screen->BrowserReact.getByRole(
    "button",
    ~options={name: BrowserLocator.String("Add")},
  )

  // type_ simulates individual keystrokes
  await BrowserUserEvent.type_(input, "Learn ReScript")
  await BrowserUserEvent.clear(input)

  // fill sets the value directly
  await BrowserUserEvent.fill(input, "Write tests")
  await BrowserUserEvent.click(addBtn)

  let todoItem = screen->BrowserReact.getByText(BrowserLocator.String("Write tests"))
  await BrowserExpect.element(todoItem)->BrowserExpect.toBeVisible

  // Submit via keyboard
  await BrowserUserEvent.fill(input, "Another task")
  await BrowserUserEvent.keyboard("{Enter}")

  let keyboardItem = screen->BrowserReact.getByText(BrowserLocator.String("Another task"))
  await BrowserExpect.element(keyboardItem)->BrowserExpect.toBeInTheDocument
})
```

### Locator chaining and filtering

```rescript
testAsync("chains queries on nested elements", async _ => {
  let screen = await BrowserReact.render(<TodoInput.TodoInput />)

  // ... add items ...

  // Chain locator queries on the list
  let list = screen->BrowserReact.getByRole("list")
  let items = list->BrowserLocator.getByRole("listitem")
  let firstItem = items->BrowserLocator.first
  let lastItem = items->BrowserLocator.last
  let _secondItem = items->BrowserLocator.nth(1)

  await BrowserExpect.element(firstItem)->BrowserExpect.toBeVisible
  await BrowserExpect.element(lastItem)->BrowserExpect.toBeVisible

  // Filter by text content
  let filtered = items->BrowserLocator.filter({hasText: BrowserLocator.String("Second")})
  await BrowserExpect.element(filtered)->BrowserExpect.toBeInTheDocument

  // Access underlying DOM elements
  let _el = firstItem->BrowserLocator.element       // Dom.element (throws if no match)
  let _maybeEl = firstItem->BrowserLocator.query     // option<Dom.element>
})
```

### DOM assertions with negation and custom timeout

```rescript
testAsync("toggles checkbox state", async _ => {
  let screen = await BrowserReact.render(
    <Toggle.Toggle label="Show details">
      {React.string("Hidden content")}
    </Toggle.Toggle>,
  )

  let checkbox = screen->BrowserReact.getByRole("checkbox")
  let content = screen->BrowserReact.getByText(BrowserLocator.String("Hidden content"))

  // Initially unchecked
  await BrowserExpect.element(checkbox)->BrowserExpect.not->BrowserExpect.toBeChecked
  await BrowserExpect.element(checkbox)->BrowserExpect.toBeEnabled

  // Content is hidden
  await BrowserExpect.element(content)->BrowserExpect.not->BrowserExpect.toBeVisible

  // Click to check
  await BrowserUserEvent.click(checkbox)

  // Retry with custom timeout
  await BrowserExpect.element(checkbox, ~options={timeout: 5000})->BrowserExpect.toBeChecked

  // Content is now visible
  await BrowserExpect.element(content)->BrowserExpect.toBeVisible
})
```

### Page-level queries, viewport, and screenshots

```rescript
testAsync("queries via BrowserPage singleton", async _ => {
  let _ = await BrowserReact.render(<Counter.Counter />)

  // BrowserPage queries the entire document
  let button = BrowserPage.getByRole(
    "button",
    ~options={name: BrowserLocator.String("Increment")},
  )
  let countText = BrowserPage.getByText(BrowserLocator.String("Count: 0"))

  await BrowserExpect.element(button)->BrowserExpect.toBeInTheDocument
  await BrowserExpect.element(countText)->BrowserExpect.toBeVisible

  // Viewport and screenshots
  await BrowserPage.viewport(1280, 720)
  let _path = await BrowserPage.screenshot()
})
```

### Testing hooks

```rescript
testAsync("useCounter hook", async _ => {
  let result = await BrowserReact.renderHook(() => UseCounter.useCounter())

  VitestExtras.Assert.equal(result.result.current.count, 0)

  await BrowserReact.HookResult.act(result, async () => {
    result.result.current.increment()
  })

  VitestExtras.Assert.equal(result.result.current.count, 1)
})
```

### Pure rendering (no auto-cleanup)

```rescript
testAsync("renders with manual cleanup", async _ => {
  BrowserReact.Pure.configure({reactStrictMode: true})

  let screen = await BrowserReact.Pure.render(<Counter.Counter />)
  let countText = screen->BrowserReact.getByText(BrowserLocator.String("Count: 0"))
  await BrowserExpect.element(countText)->BrowserExpect.toBeInTheDocument

  await BrowserReact.Pure.cleanup()
})
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
