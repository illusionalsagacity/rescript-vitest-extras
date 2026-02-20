---
"rescript-vitest-extras": minor
---

Add ReScript bindings extending rescript-vitest with:

- `VitestAssert`: Chai-style assert API with ReScript-specific assertions for `option`, `result`, `Null.t`, `Nullable.t`, and `undefined`
- `VitestMock`: Arity-specific mock function types (`mockFn0`–`mockFn5`) with mock context, implementation control, and return value stubbing
- `VitestMockExpect`: Expect matchers for mock assertions (`toHaveBeenCalled`, `toHaveBeenCalledWith`, `toHaveReturned`, etc.)
- `VitestBrowserLocator`: Locator API for browser-mode element queries, filtering, interaction, and element access
- `VitestBrowserPage`: `page` singleton with query methods, viewport control, and screenshot support
- `VitestBrowserUserEvent`: `userEvent` singleton for click, fill, type, hover, keyboard, drag-and-drop, and clipboard operations
- `VitestBrowserExpect`: `expect.element()` with 25 DOM assertion matchers (visibility, state, content, attributes, form values)
- `VitestBrowserReact`: `render` and `renderHook` bindings for `vitest-browser-react` with auto-cleanup and a `Pure` submodule
