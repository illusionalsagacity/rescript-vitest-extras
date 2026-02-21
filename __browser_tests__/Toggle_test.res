/**
 * Toggle browser tests — Exercise checkbox interactions, visibility toggling,
 * and negated assertions using the VitestBrowser* bindings.
 */
open Vitest

describe("Toggle", () => {
  testAsync("renders unchecked by default", async _ => {
    let screen = await VitestExtras.BrowserReact.render(
      <Toggle.Toggle label="Show details"> {React.string("Hidden content")} </Toggle.Toggle>,
    )

    let checkbox = screen->VitestExtras.BrowserReact.getByRole("checkbox")
    await VitestExtras.BrowserExpect.element(checkbox)
    ->VitestExtras.BrowserExpect.not
    ->VitestExtras.BrowserExpect.toBeChecked
  })

  testAsync("hides content when unchecked", async _ => {
    let screen = await VitestExtras.BrowserReact.render(
      <Toggle.Toggle label="Show details"> {React.string("Hidden content")} </Toggle.Toggle>,
    )

    let hiddenText =
      screen->VitestExtras.BrowserReact.getByText(
        VitestExtras.BrowserLocator.String("Hidden content"),
      )
    await VitestExtras.BrowserExpect.element(hiddenText)
    ->VitestExtras.BrowserExpect.not
    ->VitestExtras.BrowserExpect.toBeVisible
  })

  testAsync("shows content when checked", async _ => {
    let screen = await VitestExtras.BrowserReact.render(
      <Toggle.Toggle label="Show details"> {React.string("Hidden content")} </Toggle.Toggle>,
    )

    let checkbox = screen->VitestExtras.BrowserReact.getByRole("checkbox")
    await VitestExtras.BrowserUserEvent.click(checkbox)

    let hiddenText =
      screen->VitestExtras.BrowserReact.getByText(
        VitestExtras.BrowserLocator.String("Hidden content"),
      )
    await VitestExtras.BrowserExpect.element(hiddenText)->VitestExtras.BrowserExpect.toBeVisible
  })

  testAsync("toggles checked state on click", async _ => {
    let screen = await VitestExtras.BrowserReact.render(
      <Toggle.Toggle label="Show details"> {React.string("Hidden content")} </Toggle.Toggle>,
    )

    let checkbox = screen->VitestExtras.BrowserReact.getByRole("checkbox")

    // Initially unchecked
    await VitestExtras.BrowserExpect.element(checkbox)
    ->VitestExtras.BrowserExpect.not
    ->VitestExtras.BrowserExpect.toBeChecked

    // Click to check
    await VitestExtras.BrowserUserEvent.click(checkbox)
    await VitestExtras.BrowserExpect.element(checkbox)->VitestExtras.BrowserExpect.toBeChecked

    // Click to uncheck
    await VitestExtras.BrowserUserEvent.click(checkbox)
    await VitestExtras.BrowserExpect.element(checkbox)
    ->VitestExtras.BrowserExpect.not
    ->VitestExtras.BrowserExpect.toBeChecked
  })

  testAsync("uses custom label", async _ => {
    let screen = await VitestExtras.BrowserReact.render(
      <Toggle.Toggle label="Custom label"> {React.string("Content")} </Toggle.Toggle>,
    )

    let label =
      screen->VitestExtras.BrowserReact.getByText(
        VitestExtras.BrowserLocator.String("Custom label"),
      )
    await VitestExtras.BrowserExpect.element(label)->VitestExtras.BrowserExpect.toBeInTheDocument
  })
})
