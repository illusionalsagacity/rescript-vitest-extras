/**
 * Vitest Browser Page API bindings.
 *
 * Wraps the `page` singleton from `vitest/browser` with ergonomic ReScript
 * convenience functions. Each query method mirrors the corresponding method
 * on `VitestExtras__BrowserLocator.t` but operates on the top-level page context.
 */
/** Returns a locator for the first element matching the given ARIA role. */
let // =============================================================================
// Query Methods
// =============================================================================

getByRole: (
  ~options: VitestExtras__BrowserLocator.locatorByRoleOptions=?,
  VitestExtras__BrowserLocator.ariaRole,
) => VitestExtras__BrowserLocator.t

/** Returns a locator for the first element matching the given text content. */
let getByText: (
  ~options: VitestExtras__BrowserLocator.locatorFilterOptions=?,
  VitestExtras__BrowserLocator.stringOrRegExp,
) => VitestExtras__BrowserLocator.t

/** Returns a locator for the first element matching the given label text. */
let getByLabelText: (
  ~options: VitestExtras__BrowserLocator.locatorFilterOptions=?,
  VitestExtras__BrowserLocator.stringOrRegExp,
) => VitestExtras__BrowserLocator.t

/** Returns a locator for the first element matching the given placeholder text. */
let getByPlaceholder: (
  ~options: VitestExtras__BrowserLocator.locatorFilterOptions=?,
  VitestExtras__BrowserLocator.stringOrRegExp,
) => VitestExtras__BrowserLocator.t

/** Returns a locator for the first element matching the given alt text. */
let getByAltText: (
  ~options: VitestExtras__BrowserLocator.locatorFilterOptions=?,
  VitestExtras__BrowserLocator.stringOrRegExp,
) => VitestExtras__BrowserLocator.t

/** Returns a locator for the first element matching the given `data-testid` attribute. */
let getByTestId: VitestExtras__BrowserLocator.stringOrRegExp => VitestExtras__BrowserLocator.t

/** Returns a locator for the first element matching the given title attribute. */
let getByTitle: (
  ~options: VitestExtras__BrowserLocator.locatorFilterOptions=?,
  VitestExtras__BrowserLocator.stringOrRegExp,
) => VitestExtras__BrowserLocator.t

// =============================================================================
// Additional Methods
// =============================================================================

/** Sets the iframe viewport size. */
let viewport: (int, int) => promise<unit>

/** Takes a screenshot of the current page. Resolves with the screenshot path. */
let screenshot: (~options: {..}=?) => promise<string>

/** Wraps a DOM element in a Locator. */
let elementLocator: Dom.element => VitestExtras__BrowserLocator.t
