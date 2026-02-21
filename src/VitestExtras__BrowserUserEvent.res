/**
 * Vitest Browser UserEvent API bindings.
 *
 * These bindings wrap Vitest's browser-mode `userEvent` singleton with ergonomic
 * ReScript types. Each method is bound via `@send` with a `Binding` suffix, then
 * re-exported as an `@inline` convenience wrapper that pipes through the global
 * singleton.
 */
/** Abstract type for a UserEvent instance from `vitest/browser`. */
type t

@module("vitest/browser") @val external userEvent: t = "userEvent"

// =============================================================================
// Setup
// =============================================================================

@send external setupBinding: t => t = "setup"

/** Creates a new, independent UserEvent instance. */
@inline
let setup = () => userEvent->setupBinding

// =============================================================================
// Click Operations
// =============================================================================

@send
external clickBinding: (t, VitestExtras__BrowserLocator.t, ~options: {..}=?) => promise<unit> =
  "click"

/** Clicks the given element. */
@inline
let click = (~options=?, locator) => userEvent->clickBinding(locator, ~options?)

@send
external dblClickBinding: (t, VitestExtras__BrowserLocator.t, ~options: {..}=?) => promise<unit> =
  "dblClick"

/** Double-clicks the given element. */
@inline
let dblClick = (~options=?, locator) => userEvent->dblClickBinding(locator, ~options?)

@send
external tripleClickBinding: (
  t,
  VitestExtras__BrowserLocator.t,
  ~options: {..}=?,
) => promise<unit> = "tripleClick"

/** Triple-clicks the given element. */
@inline
let tripleClick = (~options=?, locator) => userEvent->tripleClickBinding(locator, ~options?)

// =============================================================================
// Input Operations
// =============================================================================

@send
external fillBinding: (t, VitestExtras__BrowserLocator.t, string) => promise<unit> = "fill"

/** Sets the value of an input element. Unlike `type_`, this does not simulate
    individual keystrokes and has no options parameter. */
@inline
let fill = (locator, text) => userEvent->fillBinding(locator, text)

@send
external typeBinding: (
  t,
  VitestExtras__BrowserLocator.t,
  string,
  ~options: {..}=?,
) => promise<unit> = "type"

/** Types text into the given element character by character, simulating real keyboard input.
    Named `type_` because `type` is a reserved word in ReScript. */
@inline
let type_ = (~options=?, locator, text) => userEvent->typeBinding(locator, text, ~options?)

@send
external clearBinding: (t, VitestExtras__BrowserLocator.t, ~options: {..}=?) => promise<unit> =
  "clear"

/** Clears the value of the given input element. */
@inline
let clear = (~options=?, locator) => userEvent->clearBinding(locator, ~options?)

// =============================================================================
// Keyboard
// =============================================================================

@send
external keyboardBinding: (t, string) => promise<unit> = "keyboard"

/** Sends keyboard input without targeting a specific element.
    Uses the same key syntax as `@testing-library/user-event`
    (e.g., `"{Enter}"`, `"{Shift>}A{/Shift}"`). */
@inline
let keyboard = text => userEvent->keyboardBinding(text)

@send
external tabBinding: (t, ~options: {..}=?) => promise<unit> = "tab"

/** Presses the Tab key, optionally with modifier options (e.g., `{"shift": true}`). */
@inline
let tab = (~options=?) => userEvent->tabBinding(~options?)

// =============================================================================
// Hover
// =============================================================================

@send
external hoverBinding: (t, VitestExtras__BrowserLocator.t, ~options: {..}=?) => promise<unit> =
  "hover"

/** Hovers over the given element. */
@inline
let hover = (~options=?, locator) => userEvent->hoverBinding(locator, ~options?)

@send
external unhoverBinding: (t, VitestExtras__BrowserLocator.t, ~options: {..}=?) => promise<unit> =
  "unhover"

/** Moves the pointer away from the given element. */
@inline
let unhover = (~options=?, locator) => userEvent->unhoverBinding(locator, ~options?)

// =============================================================================
// Selection
// =============================================================================

@send
external selectOptionsBinding: (
  t,
  VitestExtras__BrowserLocator.t,
  'a,
  ~options: {..}=?,
) => promise<unit> = "selectOptions"

/** Selects the given option(s) in a `<select>` element. The `values` parameter is
    intentionally polymorphic to support `string`, `array<string>`, `Locator`,
    `array<Locator>`, `Dom.element`, or `array<Dom.element>`. */
@inline
let selectOptions = (~options=?, locator, values) =>
  userEvent->selectOptionsBinding(locator, values, ~options?)

// =============================================================================
// File Upload
// =============================================================================

@send
external uploadBinding: (t, VitestExtras__BrowserLocator.t, 'a, ~options: {..}=?) => promise<unit> =
  "upload"

/** Uploads file(s) to an input element. The `files` parameter is intentionally
    polymorphic to support `string`, `array<string>`, `File`, or `array<File>`. */
@inline
let upload = (~options=?, locator, files) => userEvent->uploadBinding(locator, files, ~options?)

// =============================================================================
// Drag and Drop
// =============================================================================

@send
external dragAndDropBinding: (
  t,
  VitestExtras__BrowserLocator.t,
  VitestExtras__BrowserLocator.t,
  ~options: {..}=?,
) => promise<unit> = "dragAndDrop"

/** Drags the source element and drops it onto the target element. */
@inline
let dragAndDrop = (~options=?, source, target) =>
  userEvent->dragAndDropBinding(source, target, ~options?)

// =============================================================================
// Clipboard
// =============================================================================

@send
external copyBinding: t => promise<unit> = "copy"

/** Copies the current selection to the clipboard. */
@inline
let copy = () => userEvent->copyBinding

@send
external cutBinding: t => promise<unit> = "cut"

/** Cuts the current selection to the clipboard. */
@inline
let cut = () => userEvent->cutBinding

@send
external pasteBinding: t => promise<unit> = "paste"

/** Pastes the clipboard contents at the current cursor position. */
@inline
let paste = () => userEvent->pasteBinding
