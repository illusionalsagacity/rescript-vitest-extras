/**
 * Toggle browser tests — Exercise checkbox interactions, visibility toggling,
 * and negated assertions using the VitestBrowser* bindings.
 */

open Vitest

describe("Toggle", () => {
  testAsync("renders unchecked by default", async _ => {
    let screen = await VitestBrowserReact.render(
      <Toggle.Toggle label="Show details">
        {React.string("Hidden content")}
      </Toggle.Toggle>,
    )

    let checkbox = screen->VitestBrowserReact.getByRole("checkbox")
    await VitestBrowserExpect.element(checkbox)->VitestBrowserExpect.not->VitestBrowserExpect.toBeChecked
  })

  testAsync("hides content when unchecked", async _ => {
    let screen = await VitestBrowserReact.render(
      <Toggle.Toggle label="Show details">
        {React.string("Hidden content")}
      </Toggle.Toggle>,
    )

    let hiddenText = screen->VitestBrowserReact.getByText(
      VitestBrowserLocator.String("Hidden content"),
    )
    await VitestBrowserExpect.element(hiddenText)->VitestBrowserExpect.not->VitestBrowserExpect.toBeVisible
  })

  testAsync("shows content when checked", async _ => {
    let screen = await VitestBrowserReact.render(
      <Toggle.Toggle label="Show details">
        {React.string("Hidden content")}
      </Toggle.Toggle>,
    )

    let checkbox = screen->VitestBrowserReact.getByRole("checkbox")
    await VitestBrowserUserEvent.click(checkbox)

    let hiddenText = screen->VitestBrowserReact.getByText(
      VitestBrowserLocator.String("Hidden content"),
    )
    await VitestBrowserExpect.element(hiddenText)->VitestBrowserExpect.toBeVisible
  })

  testAsync("toggles checked state on click", async _ => {
    let screen = await VitestBrowserReact.render(
      <Toggle.Toggle label="Show details">
        {React.string("Hidden content")}
      </Toggle.Toggle>,
    )

    let checkbox = screen->VitestBrowserReact.getByRole("checkbox")

    // Initially unchecked
    await VitestBrowserExpect.element(checkbox)->VitestBrowserExpect.not->VitestBrowserExpect.toBeChecked

    // Click to check
    await VitestBrowserUserEvent.click(checkbox)
    await VitestBrowserExpect.element(checkbox)->VitestBrowserExpect.toBeChecked

    // Click to uncheck
    await VitestBrowserUserEvent.click(checkbox)
    await VitestBrowserExpect.element(checkbox)->VitestBrowserExpect.not->VitestBrowserExpect.toBeChecked
  })

  testAsync("uses custom label", async _ => {
    let screen = await VitestBrowserReact.render(
      <Toggle.Toggle label="Custom label">
        {React.string("Content")}
      </Toggle.Toggle>,
    )

    let label = screen->VitestBrowserReact.getByText(VitestBrowserLocator.String("Custom label"))
    await VitestBrowserExpect.element(label)->VitestBrowserExpect.toBeInTheDocument
  })
})
