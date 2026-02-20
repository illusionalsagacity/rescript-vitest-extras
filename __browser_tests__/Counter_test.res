/**
 * Counter browser tests — Exercise click interactions, button queries,
 * and text content assertions using the VitestBrowser* bindings.
 */

open Vitest

describe("Counter", () => {
  testAsync("displays initial count of 0", async _ => {
    let screen = await VitestBrowserReact.render(<Counter.Counter />)
    let countText = screen->VitestBrowserReact.getByText(
      VitestBrowserLocator.String("Count: 0"),
    )
    await VitestBrowserExpect.element(countText)->VitestBrowserExpect.toBeInTheDocument
  })

  testAsync("increments on Increment button click", async _ => {
    let screen = await VitestBrowserReact.render(<Counter.Counter />)

    let incrementBtn = screen->VitestBrowserReact.getByRole(
      "button",
      ~options={name: VitestBrowserLocator.String("Increment")},
    )
    await VitestBrowserUserEvent.click(incrementBtn)

    let countText = screen->VitestBrowserReact.getByText(
      VitestBrowserLocator.String("Count: 1"),
    )
    await VitestBrowserExpect.element(countText)->VitestBrowserExpect.toBeInTheDocument
  })

  testAsync("decrements on Decrement button click", async _ => {
    let screen = await VitestBrowserReact.render(<Counter.Counter />)

    let decrementBtn = screen->VitestBrowserReact.getByRole(
      "button",
      ~options={name: VitestBrowserLocator.String("Decrement")},
    )
    await VitestBrowserUserEvent.click(decrementBtn)

    let countText = screen->VitestBrowserReact.getByText(
      VitestBrowserLocator.String("Count: -1"),
    )
    await VitestBrowserExpect.element(countText)->VitestBrowserExpect.toBeInTheDocument
  })

  testAsync("increments multiple times", async _ => {
    let screen = await VitestBrowserReact.render(<Counter.Counter />)

    let incrementBtn = screen->VitestBrowserReact.getByRole(
      "button",
      ~options={name: VitestBrowserLocator.String("Increment")},
    )
    await VitestBrowserUserEvent.click(incrementBtn)
    await VitestBrowserUserEvent.click(incrementBtn)
    await VitestBrowserUserEvent.click(incrementBtn)

    let countText = screen->VitestBrowserReact.getByText(
      VitestBrowserLocator.String("Count: 3"),
    )
    await VitestBrowserExpect.element(countText)->VitestBrowserExpect.toBeInTheDocument
  })
})
