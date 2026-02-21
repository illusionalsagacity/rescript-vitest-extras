// =============================================================================
// Shared Types
// =============================================================================

/**
 * Vitest Browser Locator API bindings.
 *
 * Provides type-safe bindings for the `@vitest/browser` Locator class, including
 * query methods (getByRole, getByText, etc.), filtering, interaction, and element access.
 */
/** Opaque type for the Locator object from `@vitest/browser`. */
type t

/** ARIA role, typed as string since the set is large and extensible. */
type ariaRole = string

/** Represents `string | RegExp` in the JS API. Zero-cost via `@unboxed`. */
@unboxed
type stringOrRegExp = String(string) | RegExp(RegExp.t)

// =============================================================================
// Options Types
// =============================================================================

/** Options for `getByRole` queries. All fields are optional. */
type locatorByRoleOptions = {
  exact?: bool,
  checked?: bool,
  disabled?: bool,
  expanded?: bool,
  includeHidden?: bool,
  level?: int,
  name?: stringOrRegExp,
  pressed?: bool,
  selected?: bool,
}

/** Options for text-based queries and the `filter` method. */
type locatorFilterOptions = {
  hasText?: stringOrRegExp,
  hasNotText?: stringOrRegExp,
  has?: t,
  hasNot?: t,
}

// =============================================================================
// Escape Hatch
// =============================================================================

/** Wraps a raw DOM element as a Locator for APIs that accept `Element | Locator` at runtime. */
external fromElement: Dom.element => t = "%identity"

// =============================================================================
// Query Methods
// =============================================================================

/** Returns a locator for the first element matching the given ARIA role. */
@send
external getByRole: (t, ariaRole, ~options: locatorByRoleOptions=?) => t = "getByRole"

/** Returns a locator for the first element matching the given text content. */
@send
external getByText: (t, stringOrRegExp, ~options: locatorFilterOptions=?) => t = "getByText"

/** Returns a locator for the first element matching the given label text. */
@send
external getByLabelText: (t, stringOrRegExp, ~options: locatorFilterOptions=?) => t =
  "getByLabelText"

/** Returns a locator for the first element matching the given placeholder text. */
@send
external getByPlaceholder: (t, stringOrRegExp, ~options: locatorFilterOptions=?) => t =
  "getByPlaceholder"

/** Returns a locator for the first element matching the given alt text. */
@send
external getByAltText: (t, stringOrRegExp, ~options: locatorFilterOptions=?) => t = "getByAltText"

/** Returns a locator for the first element matching the given `data-testid` attribute. */
@send
external getByTestId: (t, stringOrRegExp) => t = "getByTestId"

/** Returns a locator for the first element matching the given title attribute. */
@send
external getByTitle: (t, stringOrRegExp, ~options: locatorFilterOptions=?) => t = "getByTitle"

// =============================================================================
// Filtering Methods
// =============================================================================

/** Returns a locator for the nth element (0-indexed) matched by this locator. */
@send
external nth: (t, int) => t = "nth"

/** Returns a locator for the first element matched by this locator. */
@send
external first: t => t = "first"

/** Returns a locator for the last element matched by this locator. */
@send
external last: t => t = "last"

/** Returns a locator matching elements that satisfy both this locator and the given locator. */
@send
external and_: (t, t) => t = "and"

/** Returns a locator matching elements that satisfy either this locator or the given locator. */
@send
external or_: (t, t) => t = "or"

/** Filters the matched elements using the provided options. */
@send
external filter: (t, locatorFilterOptions) => t = "filter"

// =============================================================================
// Interaction Methods
// =============================================================================

/** Clicks the element. Resolves when the action is complete. */
@send
external click: (t, ~options: {..}=?) => promise<unit> = "click"

/** Double-clicks the element. Resolves when the action is complete. */
@send
external dblClick: (t, ~options: {..}=?) => promise<unit> = "dblClick"

/** Triple-clicks the element. Resolves when the action is complete. */
@send
external tripleClick: (t, ~options: {..}=?) => promise<unit> = "tripleClick"

/** Clears the input element's value. Resolves when the action is complete. */
@send
external clear: (t, ~options: {..}=?) => promise<unit> = "clear"

/** Hovers over the element. Resolves when the action is complete. */
@send
external hover: (t, ~options: {..}=?) => promise<unit> = "hover"

/** Moves the pointer away from the element. Resolves when the action is complete. */
@send
external unhover: (t, ~options: {..}=?) => promise<unit> = "unhover"

/** Types the given text into the input element. Resolves when the action is complete. */
@send
external fill: (t, string, ~options: {..}=?) => promise<unit> = "fill"

/** Drags the source element and drops it onto the given target locator. */
@send
external dropTo: (t, t, ~options: {..}=?) => promise<unit> = "dropTo"

/** Selects the given options in a `<select>` element. The value type is intentionally
    polymorphic to support `string`, `array<string>`, `HTMLElement`, or `array<HTMLElement>`. */
@send
external selectOptions: (t, 'a, ~options: {..}=?) => promise<unit> = "selectOptions"

/** Takes a screenshot of the element. Resolves with the screenshot path. */
@send
external screenshot: (t, ~options: {..}=?) => promise<string> = "screenshot"

// =============================================================================
// Element Access
// =============================================================================

/** Returns the matched DOM element, or `None` if no element matches. */
@send @return(nullable)
external query: t => option<Dom.element> = "query"

/** Returns the matched DOM element. Throws if no element matches. */
@send
external element: t => Dom.element = "element"

/** Returns all matched DOM elements as an array. */
@send
external elements: t => array<Dom.element> = "elements"

/** Returns all matched locators as an array. */
@send
external all: t => array<t> = "all"

// =============================================================================
// Properties
// =============================================================================

/** The CSS selector string for this locator. */
@get
external selector: t => string = "selector"

/** The number of elements matched by this locator. */
@get
external length: t => int = "length"
