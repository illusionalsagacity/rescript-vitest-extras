---
"rescript-vitest-extras": minor
---

Add ReScript bindings extending rescript-vitest with:

- `VitestAssert`: Chai-style assert API (`assert.equal`, `assert.deepEqual`, `assert.throws`, etc.) with ReScript-specific assertions for `option`, `result`, `Null.t`, `Nullable.t`, and `undefined`
- `VitestMock`: Arity-specific mock function types (`mockFn0` through `mockFn5`) with full access to mock context, implementation control, and return value stubbing
- `VitestMockExpect`: Expect matchers for mock assertions (`toHaveBeenCalled`, `toHaveBeenCalledWith`, `toHaveReturned`, etc.)
