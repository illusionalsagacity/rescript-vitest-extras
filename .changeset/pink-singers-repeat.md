---
"rescript-vitest-extras": minor
---

Add ReScript bindings extending rescript-vitest with:

- `VitestExtras.Assert`: Chai-style assert API with ReScript-specific assertions for `option`, `result`, `Null.t`, `Nullable.t`, and `undefined`
- `VitestExtras.Mock`: Arity-specific mock function types (`mockFn0`–`mockFn5`) with mock context, implementation control, and return value stubbing
- `VitestExtras.MockExpect`: Expect matchers for mock assertions (`toHaveBeenCalled`, `toHaveBeenCalledWith`, `toHaveReturned`, etc.)
- `VitestExtras.BrowserLocator`: Locator API for browser-mode element queries, filtering, interaction, and element access
- `VitestExtras.BrowserPage`: `page` singleton with query methods, viewport control, and screenshot support
- `VitestExtras.BrowserUserEvent`: `userEvent` singleton for click, fill, type, hover, keyboard, drag-and-drop, and clipboard operations
- `VitestExtras.BrowserExpect`: `expect.element()` with 25 DOM assertion matchers (visibility, state, content, attributes, form values)
- `VitestExtras.BrowserReact`: `render` and `renderHook` bindings for `vitest-browser-react` with auto-cleanup and a `Pure` submodule
