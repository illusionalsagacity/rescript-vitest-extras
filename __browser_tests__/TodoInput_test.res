/**
 * TodoInput browser tests — Exercise text input, button disabled states,
 * form submission, and list rendering using the VitestBrowser* bindings.
 */
open Vitest

describe("TodoInput", () => {
  testAsync("renders input and disabled add button", async _ => {
    let screen = await VitestExtras.BrowserReact.render(<TodoInput.TodoInput />)

    let input =
      screen->VitestExtras.BrowserReact.getByPlaceholder(
        VitestExtras.BrowserLocator.String("Enter a todo..."),
      )
    await VitestExtras.BrowserExpect.element(input)->VitestExtras.BrowserExpect.toBeInTheDocument

    let addBtn =
      screen->VitestExtras.BrowserReact.getByRole(
        "button",
        ~options={name: VitestExtras.BrowserLocator.String("Add")},
      )
    await VitestExtras.BrowserExpect.element(addBtn)->VitestExtras.BrowserExpect.toBeDisabled
  })

  testAsync("enables Add button when input has text", async _ => {
    let screen = await VitestExtras.BrowserReact.render(<TodoInput.TodoInput />)

    let input =
      screen->VitestExtras.BrowserReact.getByPlaceholder(
        VitestExtras.BrowserLocator.String("Enter a todo..."),
      )
    await VitestExtras.BrowserUserEvent.fill(input, "Learn ReScript")

    let addBtn =
      screen->VitestExtras.BrowserReact.getByRole(
        "button",
        ~options={name: VitestExtras.BrowserLocator.String("Add")},
      )
    await VitestExtras.BrowserExpect.element(addBtn)->VitestExtras.BrowserExpect.toBeEnabled
  })

  testAsync("disables Add button when input is empty", async _ => {
    let screen = await VitestExtras.BrowserReact.render(<TodoInput.TodoInput />)

    let input =
      screen->VitestExtras.BrowserReact.getByPlaceholder(
        VitestExtras.BrowserLocator.String("Enter a todo..."),
      )
    await VitestExtras.BrowserUserEvent.fill(input, "Learn ReScript")
    await VitestExtras.BrowserUserEvent.clear(input)

    let addBtn =
      screen->VitestExtras.BrowserReact.getByRole(
        "button",
        ~options={name: VitestExtras.BrowserLocator.String("Add")},
      )
    await VitestExtras.BrowserExpect.element(addBtn)->VitestExtras.BrowserExpect.toBeDisabled
  })

  testAsync("adds todo item on button click", async _ => {
    let screen = await VitestExtras.BrowserReact.render(<TodoInput.TodoInput />)

    let input =
      screen->VitestExtras.BrowserReact.getByPlaceholder(
        VitestExtras.BrowserLocator.String("Enter a todo..."),
      )
    await VitestExtras.BrowserUserEvent.fill(input, "Write tests")

    let addBtn =
      screen->VitestExtras.BrowserReact.getByRole(
        "button",
        ~options={name: VitestExtras.BrowserLocator.String("Add")},
      )
    await VitestExtras.BrowserUserEvent.click(addBtn)

    let todoItem =
      screen->VitestExtras.BrowserReact.getByText(VitestExtras.BrowserLocator.String("Write tests"))
    await VitestExtras.BrowserExpect.element(todoItem)->VitestExtras.BrowserExpect.toBeInTheDocument
  })

  testAsync("clears input after adding todo", async _ => {
    let screen = await VitestExtras.BrowserReact.render(<TodoInput.TodoInput />)

    let input =
      screen->VitestExtras.BrowserReact.getByPlaceholder(
        VitestExtras.BrowserLocator.String("Enter a todo..."),
      )
    await VitestExtras.BrowserUserEvent.fill(input, "Buy groceries")

    let addBtn =
      screen->VitestExtras.BrowserReact.getByRole(
        "button",
        ~options={name: VitestExtras.BrowserLocator.String("Add")},
      )
    await VitestExtras.BrowserUserEvent.click(addBtn)

    await VitestExtras.BrowserExpect.element(input)->VitestExtras.BrowserExpect.toHaveValue("")
  })

  testAsync("adds multiple todos", async _ => {
    let screen = await VitestExtras.BrowserReact.render(<TodoInput.TodoInput />)

    let input =
      screen->VitestExtras.BrowserReact.getByPlaceholder(
        VitestExtras.BrowserLocator.String("Enter a todo..."),
      )
    let addBtn =
      screen->VitestExtras.BrowserReact.getByRole(
        "button",
        ~options={name: VitestExtras.BrowserLocator.String("Add")},
      )

    await VitestExtras.BrowserUserEvent.fill(input, "Task 1")
    await VitestExtras.BrowserUserEvent.click(addBtn)

    await VitestExtras.BrowserUserEvent.fill(input, "Task 2")
    await VitestExtras.BrowserUserEvent.click(addBtn)

    await VitestExtras.BrowserUserEvent.fill(input, "Task 3")
    await VitestExtras.BrowserUserEvent.click(addBtn)

    let task1 =
      screen->VitestExtras.BrowserReact.getByText(VitestExtras.BrowserLocator.String("Task 1"))
    let task2 =
      screen->VitestExtras.BrowserReact.getByText(VitestExtras.BrowserLocator.String("Task 2"))
    let task3 =
      screen->VitestExtras.BrowserReact.getByText(VitestExtras.BrowserLocator.String("Task 3"))

    await VitestExtras.BrowserExpect.element(task1)->VitestExtras.BrowserExpect.toBeInTheDocument
    await VitestExtras.BrowserExpect.element(task2)->VitestExtras.BrowserExpect.toBeInTheDocument
    await VitestExtras.BrowserExpect.element(task3)->VitestExtras.BrowserExpect.toBeInTheDocument
  })

  testAsync("adds todo on Enter key press", async _ => {
    let screen = await VitestExtras.BrowserReact.render(<TodoInput.TodoInput />)

    let input =
      screen->VitestExtras.BrowserReact.getByPlaceholder(
        VitestExtras.BrowserLocator.String("Enter a todo..."),
      )
    await VitestExtras.BrowserUserEvent.fill(input, "Press Enter")
    await VitestExtras.BrowserUserEvent.keyboard("{Enter}")

    let todoItem =
      screen->VitestExtras.BrowserReact.getByText(VitestExtras.BrowserLocator.String("Press Enter"))
    await VitestExtras.BrowserExpect.element(todoItem)->VitestExtras.BrowserExpect.toBeInTheDocument
  })
})
