/**
 * Vitest Browser Page API bindings.
 *
 * Wraps the `page` singleton from `vitest/browser` with ergonomic ReScript
 * convenience functions. Each query method mirrors the corresponding method
 * on `VitestBrowserLocator.t` but operates on the top-level page context.
 */

// =============================================================================
// Page Singleton
// =============================================================================

/** Abstract type for the Page object from `vitest/browser`. */
type t

@module("vitest/browser") @val external page: t = "page"

// =============================================================================
// Query Methods
// =============================================================================

@send
external getByRoleBinding: (t, VitestBrowserLocator.ariaRole, ~options: VitestBrowserLocator.locatorByRoleOptions=?) => VitestBrowserLocator.t = "getByRole"

/** Returns a locator for the first element matching the given ARIA role. */
@inline
let getByRole = (~options=?, role) => page->getByRoleBinding(role, ~options?)

@send
external getByTextBinding: (t, VitestBrowserLocator.stringOrRegExp, ~options: VitestBrowserLocator.locatorFilterOptions=?) => VitestBrowserLocator.t = "getByText"

/** Returns a locator for the first element matching the given text content. */
@inline
let getByText = (~options=?, text) => page->getByTextBinding(text, ~options?)

@send
external getByLabelTextBinding: (t, VitestBrowserLocator.stringOrRegExp, ~options: VitestBrowserLocator.locatorFilterOptions=?) => VitestBrowserLocator.t = "getByLabelText"

/** Returns a locator for the first element matching the given label text. */
@inline
let getByLabelText = (~options=?, text) => page->getByLabelTextBinding(text, ~options?)

@send
external getByPlaceholderBinding: (t, VitestBrowserLocator.stringOrRegExp, ~options: VitestBrowserLocator.locatorFilterOptions=?) => VitestBrowserLocator.t = "getByPlaceholder"

/** Returns a locator for the first element matching the given placeholder text. */
@inline
let getByPlaceholder = (~options=?, text) => page->getByPlaceholderBinding(text, ~options?)

@send
external getByAltTextBinding: (t, VitestBrowserLocator.stringOrRegExp, ~options: VitestBrowserLocator.locatorFilterOptions=?) => VitestBrowserLocator.t = "getByAltText"

/** Returns a locator for the first element matching the given alt text. */
@inline
let getByAltText = (~options=?, text) => page->getByAltTextBinding(text, ~options?)

@send
external getByTestIdBinding: (t, VitestBrowserLocator.stringOrRegExp) => VitestBrowserLocator.t = "getByTestId"

/** Returns a locator for the first element matching the given `data-testid` attribute. */
@inline
let getByTestId = testId => page->getByTestIdBinding(testId)

@send
external getByTitleBinding: (t, VitestBrowserLocator.stringOrRegExp, ~options: VitestBrowserLocator.locatorFilterOptions=?) => VitestBrowserLocator.t = "getByTitle"

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

@send external elementLocatorBinding: (t, Dom.element) => VitestBrowserLocator.t = "elementLocator"

/** Wraps a DOM element in a Locator. */
@inline
let elementLocator = element => page->elementLocatorBinding(element)
