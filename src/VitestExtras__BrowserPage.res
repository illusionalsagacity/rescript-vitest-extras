// =============================================================================
// Page Singleton
// =============================================================================

/**
 * Vitest Browser Page API bindings.
 *
 * Wraps the `page` singleton from `vitest/browser` with ergonomic ReScript
 * convenience functions. Each query method mirrors the corresponding method
 * on `VitestExtras__BrowserLocator.t` but operates on the top-level page context.
 */
/** Abstract type for the Page object from `vitest/browser`. */
type t

@module("vitest/browser") @val external page: t = "page"

// =============================================================================
// Query Methods
// =============================================================================

@send
external getByRoleBinding: (
  t,
  VitestExtras__BrowserLocator.ariaRole,
  ~options: VitestExtras__BrowserLocator.locatorByRoleOptions=?,
) => VitestExtras__BrowserLocator.t = "getByRole"

/** Returns a locator for the first element matching the given ARIA role. */
@inline
let getByRole = (~options=?, role) => page->getByRoleBinding(role, ~options?)

@send
external getByTextBinding: (
  t,
  VitestExtras__BrowserLocator.stringOrRegExp,
  ~options: VitestExtras__BrowserLocator.locatorFilterOptions=?,
) => VitestExtras__BrowserLocator.t = "getByText"

/** Returns a locator for the first element matching the given text content. */
@inline
let getByText = (~options=?, text) => page->getByTextBinding(text, ~options?)

@send
external getByLabelTextBinding: (
  t,
  VitestExtras__BrowserLocator.stringOrRegExp,
  ~options: VitestExtras__BrowserLocator.locatorFilterOptions=?,
) => VitestExtras__BrowserLocator.t = "getByLabelText"

/** Returns a locator for the first element matching the given label text. */
@inline
let getByLabelText = (~options=?, text) => page->getByLabelTextBinding(text, ~options?)

@send
external getByPlaceholderBinding: (
  t,
  VitestExtras__BrowserLocator.stringOrRegExp,
  ~options: VitestExtras__BrowserLocator.locatorFilterOptions=?,
) => VitestExtras__BrowserLocator.t = "getByPlaceholder"

/** Returns a locator for the first element matching the given placeholder text. */
@inline
let getByPlaceholder = (~options=?, text) => page->getByPlaceholderBinding(text, ~options?)

@send
external getByAltTextBinding: (
  t,
  VitestExtras__BrowserLocator.stringOrRegExp,
  ~options: VitestExtras__BrowserLocator.locatorFilterOptions=?,
) => VitestExtras__BrowserLocator.t = "getByAltText"

/** Returns a locator for the first element matching the given alt text. */
@inline
let getByAltText = (~options=?, text) => page->getByAltTextBinding(text, ~options?)

@send
external getByTestIdBinding: (
  t,
  VitestExtras__BrowserLocator.stringOrRegExp,
) => VitestExtras__BrowserLocator.t = "getByTestId"

/** Returns a locator for the first element matching the given `data-testid` attribute. */
@inline
let getByTestId = testId => page->getByTestIdBinding(testId)

@send
external getByTitleBinding: (
  t,
  VitestExtras__BrowserLocator.stringOrRegExp,
  ~options: VitestExtras__BrowserLocator.locatorFilterOptions=?,
) => VitestExtras__BrowserLocator.t = "getByTitle"

/** Returns a locator for the first element matching the given title attribute. */
@inline
let getByTitle = (~options=?, text) => page->getByTitleBinding(text, ~options?)

// =============================================================================
// Additional Methods
// =============================================================================

@send external viewportBinding: (t, int, int) => promise<unit> = "viewport"

/** Sets the iframe viewport size. */
@inline
let viewport = (width, height) => page->viewportBinding(width, height)

@send external screenshotBinding: (t, ~options: {..}=?) => promise<string> = "screenshot"

/** Takes a screenshot of the current page. Resolves with the screenshot path. */
@inline
let screenshot = (~options=?) => page->screenshotBinding(~options?)

@send
external elementLocatorBinding: (t, Dom.element) => VitestExtras__BrowserLocator.t =
  "elementLocator"

/** Wraps a DOM element in a Locator. */
@inline
let elementLocator = element => page->elementLocatorBinding(element)
