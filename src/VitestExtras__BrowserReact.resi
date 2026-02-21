// =============================================================================
// Types
// =============================================================================

/**
 * Vitest Browser React API bindings.
 *
 * Provides type-safe bindings for `vitest-browser-react`, including `render`,
 * `renderHook`, `cleanup`, and the `Pure` submodule with `configure`.
 * The `renderResult` type extends `LocatorSelectors` with query methods,
 * property accessors, and lifecycle methods.
 */
/** The result of rendering a component. Extends Locator with query methods. */
type renderResult

/** Options for rendering a component. */
type componentRenderOptions = {
  container?: Dom.element,
  baseElement?: Dom.element,
  wrapper?: React.component<{children: React.element}>,
}

/** Options for `renderHook`. Extends `componentRenderOptions` with `initialProps`. */
type renderHookOptions<'props> = {
  container?: Dom.element,
  baseElement?: Dom.element,
  wrapper?: React.component<{children: React.element}>,
  initialProps?: 'props,
}

/** The result of rendering a hook. */
type renderHookResult<'result> = {
  result: {current: 'result},
}

// =============================================================================
// renderResult — Query Methods
// =============================================================================

/** Returns a locator for the first element matching the given ARIA role. */
@send
external getByRole: (
  renderResult,
  VitestExtras__BrowserLocator.ariaRole,
  ~options: VitestExtras__BrowserLocator.locatorByRoleOptions=?,
) => VitestExtras__BrowserLocator.t = "getByRole"

/** Returns a locator for the first element matching the given text content. */
@send
external getByText: (
  renderResult,
  VitestExtras__BrowserLocator.stringOrRegExp,
  ~options: VitestExtras__BrowserLocator.locatorFilterOptions=?,
) => VitestExtras__BrowserLocator.t = "getByText"

/** Returns a locator for the first element matching the given label text. */
@send
external getByLabelText: (
  renderResult,
  VitestExtras__BrowserLocator.stringOrRegExp,
  ~options: VitestExtras__BrowserLocator.locatorFilterOptions=?,
) => VitestExtras__BrowserLocator.t = "getByLabelText"

/** Returns a locator for the first element matching the given placeholder text. */
@send
external getByPlaceholder: (
  renderResult,
  VitestExtras__BrowserLocator.stringOrRegExp,
  ~options: VitestExtras__BrowserLocator.locatorFilterOptions=?,
) => VitestExtras__BrowserLocator.t = "getByPlaceholder"

/** Returns a locator for the first element matching the given alt text. */
@send
external getByAltText: (
  renderResult,
  VitestExtras__BrowserLocator.stringOrRegExp,
  ~options: VitestExtras__BrowserLocator.locatorFilterOptions=?,
) => VitestExtras__BrowserLocator.t = "getByAltText"

/** Returns a locator for the first element matching the given `data-testid` attribute. */
@send
external getByTestId: (
  renderResult,
  VitestExtras__BrowserLocator.stringOrRegExp,
) => VitestExtras__BrowserLocator.t = "getByTestId"

/** Returns a locator for the first element matching the given title attribute. */
@send
external getByTitle: (
  renderResult,
  VitestExtras__BrowserLocator.stringOrRegExp,
  ~options: VitestExtras__BrowserLocator.locatorFilterOptions=?,
) => VitestExtras__BrowserLocator.t = "getByTitle"

// =============================================================================
// renderResult — Property Accessors
// =============================================================================

/** The container DOM element that the component was rendered into. */
@get
external container: renderResult => Dom.element = "container"

/** The base element for queries. Defaults to `document.body`. */
@get
external baseElement: renderResult => Dom.element = "baseElement"

/** The root Locator for the rendered output. */
@get
external locator: renderResult => VitestExtras__BrowserLocator.t = "locator"

// =============================================================================
// renderResult — Lifecycle Methods
// =============================================================================

/** Unmounts the rendered component. */
@send
external unmount: renderResult => promise<unit> = "unmount"

/** Re-renders the component with new props by passing a new React element. */
@send
external rerender: (renderResult, React.element) => promise<unit> = "rerender"

/** Returns a `DocumentFragment` of the rendered output. */
@send
external asFragment: renderResult => Dom.element = "asFragment"

// =============================================================================
// renderResult — Escape Hatch
// =============================================================================

/** Casts a `renderResult` to a `VitestExtras__BrowserLocator.t` for use with Locator APIs. */
external toLocator: renderResult => VitestExtras__BrowserLocator.t = "%identity"

// =============================================================================
// renderHookResult — Methods (nested to avoid name collisions)
// =============================================================================

/** Methods on `renderHookResult`. Nested to avoid name collisions with `renderResult` methods. */
module HookResult: {
  /** Runs the given callback inside `act()`. */
  @send
  external act: (renderHookResult<'result>, unit => promise<unit>) => promise<unit> = "act"

  /** Re-renders the hook with new props. */
  @send
  external rerender: (renderHookResult<'result>, 'props) => promise<unit> = "rerender"

  /** Unmounts the rendered hook. */
  @send
  external unmount: renderHookResult<'result> => promise<unit> = "unmount"
}

// =============================================================================
// Top-level Functions (auto-cleanup via vitest-browser-react)
// =============================================================================

/** Renders a React element into the DOM and returns a `renderResult`. Uses auto-cleanup. */
@module("vitest-browser-react")
external render: (React.element, ~options: componentRenderOptions=?) => promise<renderResult> =
  "render"

/** Renders a custom hook and returns its result. Uses auto-cleanup. */
@module("vitest-browser-react")
external renderHook: (
  'props => 'result,
  ~options: renderHookOptions<'props>=?,
) => promise<renderHookResult<'result>> = "renderHook"

/** Unmounts all rendered components. Normally called automatically after each test. */
@module("vitest-browser-react")
external cleanup: unit => promise<unit> = "cleanup"

// =============================================================================
// Pure Submodule (no auto-cleanup, manual control)
// =============================================================================

/** Pure exports from `vitest-browser-react/pure`. No auto-cleanup; call `cleanup` manually. */
module Pure: {
  /** Configuration options for the React renderer. */
  type configOptions = {reactStrictMode?: bool}

  /** Renders a React element into the DOM and returns a `renderResult`. No auto-cleanup. */
  @module("vitest-browser-react/pure")
  external render: (React.element, ~options: componentRenderOptions=?) => promise<renderResult> =
    "render"

  /** Renders a custom hook and returns its result. No auto-cleanup. */
  @module("vitest-browser-react/pure")
  external renderHook: (
    'props => 'result,
    ~options: renderHookOptions<'props>=?,
  ) => promise<renderHookResult<'result>> = "renderHook"

  /** Unmounts all rendered components. Must be called manually when using `Pure`. */
  @module("vitest-browser-react/pure")
  external cleanup: unit => promise<unit> = "cleanup"

  /** Configures the React renderer (e.g., enabling strict mode). */
  @module("vitest-browser-react/pure")
  external configure: configOptions => unit = "configure"
}
