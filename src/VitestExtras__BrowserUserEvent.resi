/**
 * Vitest Browser UserEvent API bindings.
 *
 * These bindings wrap Vitest's browser-mode `userEvent` singleton with ergonomic
 * ReScript types. Each function below uses the default global `userEvent` instance
 * imported from `vitest/browser`.
 *
 * For an independent instance, call `setup()` to obtain a fresh `t`.
 */
/** Opaque type for a UserEvent instance from `vitest/browser`. */
type t

// =============================================================================
// Setup
// =============================================================================

/** Creates a new, independent UserEvent instance. */
let setup: unit => t

// =============================================================================
// Click Operations
// =============================================================================

/** Clicks the given element. */
let click: (~options: {..}=?, VitestExtras__BrowserLocator.t) => promise<unit>

/** Double-clicks the given element. */
let dblClick: (~options: {..}=?, VitestExtras__BrowserLocator.t) => promise<unit>

/** Triple-clicks the given element. */
let tripleClick: (~options: {..}=?, VitestExtras__BrowserLocator.t) => promise<unit>

// =============================================================================
// Input Operations
// =============================================================================

/** Sets the value of an input element. Unlike `type_`, this does not simulate
    individual keystrokes and has no options parameter. */
let fill: (VitestExtras__BrowserLocator.t, string) => promise<unit>

/** Types text into the given element character by character, simulating real keyboard input.
    Named `type_` because `type` is a reserved word in ReScript. */
let type_: (~options: {..}=?, VitestExtras__BrowserLocator.t, string) => promise<unit>

/** Clears the value of the given input element. */
let clear: (~options: {..}=?, VitestExtras__BrowserLocator.t) => promise<unit>

// =============================================================================
// Keyboard
// =============================================================================

/** Sends keyboard input without targeting a specific element.
    Uses the same key syntax as `@testing-library/user-event`
    (e.g., `"{Enter}"`, `"{Shift>}A{/Shift}"`). */
let keyboard: string => promise<unit>

/** Presses the Tab key, optionally with modifier options (e.g., `{"shift": true}`). */
let tab: (~options: {..}=?) => promise<unit>

// =============================================================================
// Hover
// =============================================================================

/** Hovers over the given element. */
let hover: (~options: {..}=?, VitestExtras__BrowserLocator.t) => promise<unit>

/** Moves the pointer away from the given element. */
let unhover: (~options: {..}=?, VitestExtras__BrowserLocator.t) => promise<unit>

// =============================================================================
// Selection
// =============================================================================

/** Selects the given option(s) in a `<select>` element. The `values` parameter is
    intentionally polymorphic to support `string`, `array<string>`, `Locator`,
    `array<Locator>`, `Dom.element`, or `array<Dom.element>`. */
let selectOptions: (~options: {..}=?, VitestExtras__BrowserLocator.t, 'a) => promise<unit>

// =============================================================================
// File Upload
// =============================================================================

/** Uploads file(s) to an input element. The `files` parameter is intentionally
    polymorphic to support `string`, `array<string>`, `File`, or `array<File>`. */
let upload: (~options: {..}=?, VitestExtras__BrowserLocator.t, 'a) => promise<unit>

// =============================================================================
// Drag and Drop
// =============================================================================

/** Drags the source element and drops it onto the target element. */
let dragAndDrop: (
  ~options: {..}=?,
  VitestExtras__BrowserLocator.t,
  VitestExtras__BrowserLocator.t,
) => promise<unit>

// =============================================================================
// Clipboard
// =============================================================================

/** Copies the current selection to the clipboard. */
let copy: unit => promise<unit>

/** Cuts the current selection to the clipboard. */
let cut: unit => promise<unit>

/** Pastes the clipboard contents at the current cursor position. */
let paste: unit => promise<unit>
