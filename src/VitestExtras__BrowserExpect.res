// =============================================================================
// Core Type and Entry Point
// =============================================================================

/**
 * Vitest Browser DOM Assertion API bindings.
 *
 * Provides type-safe bindings for `expect.element()` and the DOM matchers from
 * `@vitest/browser`. All matchers return `promise<unit>` because `expect.element()`
 * wraps `expect.poll()`, which retries assertions until they pass or timeout.
 */
/** The assertion type returned by `expect.element()`. All matchers return `promise<unit>`. */
type t

/** Options for controlling the retry behavior of `expect.element()`. */
type expectPollOptions = {
  interval?: int,
  timeout?: int,
  message?: string,
}

/** Creates a DOM element assertion from a Locator. Automatically retries until passing or timeout. */
@module("vitest") @scope("expect")
external element: (VitestExtras__BrowserLocator.t, ~options: expectPollOptions=?) => t = "element"

/** Negates the following assertion. */
@get external not: t => t = "not"

// =============================================================================
// State Matchers
// =============================================================================

/** Asserts that the element is disabled. */
@send
external toBeDisabled: t => promise<unit> = "toBeDisabled"

/** Asserts that the element is enabled (not disabled). */
@send
external toBeEnabled: t => promise<unit> = "toBeEnabled"

/** Asserts that the checkbox or radio input is checked. */
@send
external toBeChecked: t => promise<unit> = "toBeChecked"

/** Asserts that the checkbox is in an indeterminate (partially checked) state. */
@send
external toBePartiallyChecked: t => promise<unit> = "toBePartiallyChecked"

/** Asserts that the form element has the `required` attribute. */
@send
external toBeRequired: t => promise<unit> = "toBeRequired"

/** Asserts that the form element passes validation. */
@send
external toBeValid: t => promise<unit> = "toBeValid"

/** Asserts that the form element fails validation. */
@send
external toBeInvalid: t => promise<unit> = "toBeInvalid"

// =============================================================================
// Visibility Matchers
// =============================================================================

/** Asserts that the element is visible to the user. */
@send
external toBeVisible: t => promise<unit> = "toBeVisible"

/** Asserts that the element is present in the document. */
@send
external toBeInTheDocument: t => promise<unit> = "toBeInTheDocument"

/** Asserts that the element has no visible content (no text, no child elements). */
@send
external toBeEmptyDOMElement: t => promise<unit> = "toBeEmptyDOMElement"

// =============================================================================
// Content Matchers
// =============================================================================

/** Asserts that the element has the expected text content. Accepts a string or RegExp. */
@send
external toHaveTextContent: (t, VitestExtras__BrowserLocator.stringOrRegExp) => promise<unit> =
  "toHaveTextContent"

/** Asserts that the element contains the given element as a descendant. Accepts a Locator. */
@send
external toContainElement: (t, VitestExtras__BrowserLocator.t) => promise<unit> = "toContainElement"

/** Asserts that the element contains the given HTML string in its `innerHTML`. */
@send
external toContainHTML: (t, string) => promise<unit> = "toContainHTML"

/** Asserts that the element has the expected accessible name. */
@send
external toHaveAccessibleName: (
  t,
  ~name: VitestExtras__BrowserLocator.stringOrRegExp=?,
) => promise<unit> = "toHaveAccessibleName"

/** Asserts that the element has the expected accessible description. */
@send
external toHaveAccessibleDescription: (
  t,
  ~description: VitestExtras__BrowserLocator.stringOrRegExp=?,
) => promise<unit> = "toHaveAccessibleDescription"

/** Asserts that the element has the expected accessible error message. */
@send
external toHaveAccessibleErrorMessage: (
  t,
  ~message: VitestExtras__BrowserLocator.stringOrRegExp=?,
) => promise<unit> = "toHaveAccessibleErrorMessage"

// =============================================================================
// Attribute Matchers
// =============================================================================

/** Asserts that the element has the given attribute, optionally with the expected value. */
@send
external toHaveAttribute: (t, string, ~value: string=?) => promise<unit> = "toHaveAttribute"

/** Asserts that the element has the given CSS class name. */
@send
external toHaveClass: (t, string) => promise<unit> = "toHaveClass"

/** Asserts that the element has the given CSS styles applied. Accepts a CSS string. */
@send
external toHaveStyle: (t, string) => promise<unit> = "toHaveStyle"

/** Asserts that the element has the given ARIA role. */
@send
external toHaveRole: (t, VitestExtras__BrowserLocator.ariaRole) => promise<unit> = "toHaveRole"

// =============================================================================
// Form Matchers
// =============================================================================

/** Asserts that the form element has the expected value. The value type is intentionally
    polymorphic to support `string`, `int`, `null`, or `array<string>`. */
@send
external toHaveValue: (t, 'a) => promise<unit> = "toHaveValue"

/** Asserts that the form element displays the expected value. The value type is intentionally
    polymorphic to support `string`, `int`, `RegExp`, or `array<string | RegExp | int>`. */
@send
external toHaveDisplayValue: (t, 'a) => promise<unit> = "toHaveDisplayValue"

/** Asserts that the form has the expected field values. Accepts an open object. */
@send
external toHaveFormValues: (t, {..}) => promise<unit> = "toHaveFormValues"

/** Asserts that the element currently has focus. */
@send
external toHaveFocus: t => promise<unit> = "toHaveFocus"

/** Asserts that the element has the expected text selection. */
@send
external toHaveSelection: (t, ~selection: string=?) => promise<unit> = "toHaveSelection"
