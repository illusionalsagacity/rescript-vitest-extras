/**
 * Browser mode README examples — These tests verify that the code examples
 * in README.md compile and exercise the browser mode API surface.
 */
open Vitest
open VitestExtras

describe("Rendering and asserting", () => {
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

describe("Form interaction and user events", () => {
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
})

describe("Locator chaining and filtering", () => {
  testAsync("chains queries on nested elements", async _ => {
    let screen = await BrowserReact.render(<TodoInput.TodoInput />)

    let input = screen->BrowserReact.getByPlaceholder(BrowserLocator.String("Enter a todo..."))
    let addBtn = screen->BrowserReact.getByRole(
      "button",
      ~options={name: BrowserLocator.String("Add")},
    )

    // Add multiple items
    await BrowserUserEvent.fill(input, "First task")
    await BrowserUserEvent.click(addBtn)
    await BrowserUserEvent.fill(input, "Second task")
    await BrowserUserEvent.click(addBtn)
    await BrowserUserEvent.fill(input, "Third task")
    await BrowserUserEvent.click(addBtn)

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
    let _el = firstItem->BrowserLocator.element
    let _maybeEl = firstItem->BrowserLocator.query
  })
})

describe("DOM assertions with negation", () => {
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
})

describe("Page-level queries", () => {
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
})

describe("Testing hooks", () => {
  testAsync("useCounter hook", async _ => {
    let result = await BrowserReact.renderHook(() => UseCounter.useCounter())

    VitestExtras.Assert.equal(result.result.current.count, 0)

    await BrowserReact.HookResult.act(result, async () => {
      result.result.current.increment()
    })

    VitestExtras.Assert.equal(result.result.current.count, 1)
  })
})

describe("Pure rendering", () => {
  testAsync("renders with manual cleanup", async _ => {
    BrowserReact.Pure.configure({reactStrictMode: true})

    let screen = await BrowserReact.Pure.render(<Counter.Counter />)
    let countText = screen->BrowserReact.getByText(BrowserLocator.String("Count: 0"))
    await BrowserExpect.element(countText)->BrowserExpect.toBeInTheDocument

    await BrowserReact.Pure.cleanup()
  })
})
