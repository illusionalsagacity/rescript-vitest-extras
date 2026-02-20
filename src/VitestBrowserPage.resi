/**
 * Vitest Browser Page API bindings.
 *
 * Wraps the `page` singleton from `vitest/browser` with ergonomic ReScript
 * convenience functions. Each query method mirrors the corresponding method
 * on `VitestBrowserLocator.t` but operates on the top-level page context.
 */

// =============================================================================
// Query Methods
// =============================================================================

/** Returns a locator for the first element matching the given ARIA role. */
let getByRole: (
  ~options: VitestBrowserLocator.locatorByRoleOptions=?,
  VitestBrowserLocator.ariaRole,
) => VitestBrowserLocator.t

/** Returns a locator for the first element matching the given text content. */
let getByText: (
  ~options: VitestBrowserLocator.locatorFilterOptions=?,
  VitestBrowserLocator.stringOrRegExp,
) => VitestBrowserLocator.t

/** Returns a locator for the first element matching the given label text. */
let getByLabelText: (
  ~options: VitestBrowserLocator.locatorFilterOptions=?,
  VitestBrowserLocator.stringOrRegExp,
) => VitestBrowserLocator.t

/** Returns a locator for the first element matching the given placeholder text. */
let getByPlaceholder: (
  ~options: VitestBrowserLocator.locatorFilterOptions=?,
  VitestBrowserLocator.stringOrRegExp,
) => VitestBrowserLocator.t

/** Returns a locator for the first element matching the given alt text. */
let getByAltText: (
  ~options: VitestBrowserLocator.locatorFilterOptions=?,
  VitestBrowserLocator.stringOrRegExp,
) => VitestBrowserLocator.t

/** Returns a locator for the first element matching the given `data-testid` attribute. */
let getByTestId: VitestBrowserLocator.stringOrRegExp => VitestBrowserLocator.t

/** Returns a locator for the first element matching the given title attribute. */
let getByTitle: (
  ~options: VitestBrowserLocator.locatorFilterOptions=?,
  VitestBrowserLocator.stringOrRegExp,
) => VitestBrowserLocator.t

// =============================================================================
// Additional Methods
// =============================================================================

/** Sets the iframe viewport size. */
let viewport: (int, int) => promise<unit>

/** Takes a screenshot of the current page. Resolves with the screenshot path. */
let screenshot: (~options: {..}=?) => promise<string>

/** Wraps a DOM element in a Locator. */
let elementLocator: Dom.element => VitestBrowserLocator.t
