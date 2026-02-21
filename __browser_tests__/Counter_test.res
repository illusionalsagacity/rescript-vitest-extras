/**
 * Counter browser tests — Exercise click interactions, button queries,
 * and text content assertions using the VitestBrowser* bindings.
 */
open Vitest

describe("Counter", () => {
  testAsync("displays initial count of 0", async _ => {
    let screen = await VitestExtras.BrowserReact.render(<Counter.Counter />)
    let countText =
      screen->VitestExtras.BrowserReact.getByText(VitestExtras.BrowserLocator.String("Count: 0"))
    await VitestExtras.BrowserExpect.element(
      countText,
    )->VitestExtras.BrowserExpect.toBeInTheDocument
  })

  testAsync("increments on Increment button click", async _ => {
    let screen = await VitestExtras.BrowserReact.render(<Counter.Counter />)

    let incrementBtn =
      screen->VitestExtras.BrowserReact.getByRole(
        "button",
        ~options={name: VitestExtras.BrowserLocator.String("Increment")},
      )
    await VitestExtras.BrowserUserEvent.click(incrementBtn)

    let countText =
      screen->VitestExtras.BrowserReact.getByText(VitestExtras.BrowserLocator.String("Count: 1"))
    await VitestExtras.BrowserExpect.element(
      countText,
    )->VitestExtras.BrowserExpect.toBeInTheDocument
  })

  testAsync("decrements on Decrement button click", async _ => {
    let screen = await VitestExtras.BrowserReact.render(<Counter.Counter />)

    let decrementBtn =
      screen->VitestExtras.BrowserReact.getByRole(
        "button",
        ~options={name: VitestExtras.BrowserLocator.String("Decrement")},
      )
    await VitestExtras.BrowserUserEvent.click(decrementBtn)

    let countText =
      screen->VitestExtras.BrowserReact.getByText(VitestExtras.BrowserLocator.String("Count: -1"))
    await VitestExtras.BrowserExpect.element(
      countText,
    )->VitestExtras.BrowserExpect.toBeInTheDocument
  })

  testAsync("increments multiple times", async _ => {
    let screen = await VitestExtras.BrowserReact.render(<Counter.Counter />)

    let incrementBtn =
      screen->VitestExtras.BrowserReact.getByRole(
        "button",
        ~options={name: VitestExtras.BrowserLocator.String("Increment")},
      )
    await VitestExtras.BrowserUserEvent.click(incrementBtn)
    await VitestExtras.BrowserUserEvent.click(incrementBtn)
    await VitestExtras.BrowserUserEvent.click(incrementBtn)

    let countText =
      screen->VitestExtras.BrowserReact.getByText(VitestExtras.BrowserLocator.String("Count: 3"))
    await VitestExtras.BrowserExpect.element(
      countText,
    )->VitestExtras.BrowserExpect.toBeInTheDocument
  })
})
