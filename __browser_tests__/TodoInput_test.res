/**
 * TodoInput browser tests — Exercise text input, button disabled states,
 * form submission, and list rendering using the VitestBrowser* bindings.
 */

open Vitest

describe("TodoInput", () => {
  testAsync("renders input and disabled add button", async _ => {
    let screen = await VitestBrowserReact.render(<TodoInput.TodoInput />)

    let input = screen->VitestBrowserReact.getByPlaceholder(
      VitestBrowserLocator.String("Enter a todo..."),
    )
    await VitestBrowserExpect.element(input)->VitestBrowserExpect.toBeInTheDocument

    let addBtn = screen->VitestBrowserReact.getByRole("button", ~options={name: VitestBrowserLocator.String("Add")})
    await VitestBrowserExpect.element(addBtn)->VitestBrowserExpect.toBeDisabled
  })

  testAsync("enables Add button when input has text", async _ => {
    let screen = await VitestBrowserReact.render(<TodoInput.TodoInput />)

    let input = screen->VitestBrowserReact.getByPlaceholder(
      VitestBrowserLocator.String("Enter a todo..."),
    )
    await VitestBrowserUserEvent.fill(input, "Learn ReScript")

    let addBtn = screen->VitestBrowserReact.getByRole("button", ~options={name: VitestBrowserLocator.String("Add")})
    await VitestBrowserExpect.element(addBtn)->VitestBrowserExpect.toBeEnabled
  })

  testAsync("disables Add button when input is empty", async _ => {
    let screen = await VitestBrowserReact.render(<TodoInput.TodoInput />)

    let input = screen->VitestBrowserReact.getByPlaceholder(
      VitestBrowserLocator.String("Enter a todo..."),
    )
    await VitestBrowserUserEvent.fill(input, "Learn ReScript")
    await VitestBrowserUserEvent.clear(input)

    let addBtn = screen->VitestBrowserReact.getByRole("button", ~options={name: VitestBrowserLocator.String("Add")})
    await VitestBrowserExpect.element(addBtn)->VitestBrowserExpect.toBeDisabled
  })

  testAsync("adds todo item on button click", async _ => {
    let screen = await VitestBrowserReact.render(<TodoInput.TodoInput />)

    let input = screen->VitestBrowserReact.getByPlaceholder(
      VitestBrowserLocator.String("Enter a todo..."),
    )
    await VitestBrowserUserEvent.fill(input, "Write tests")

    let addBtn = screen->VitestBrowserReact.getByRole("button", ~options={name: VitestBrowserLocator.String("Add")})
    await VitestBrowserUserEvent.click(addBtn)

    let todoItem = screen->VitestBrowserReact.getByText(VitestBrowserLocator.String("Write tests"))
    await VitestBrowserExpect.element(todoItem)->VitestBrowserExpect.toBeInTheDocument
  })

  testAsync("clears input after adding todo", async _ => {
    let screen = await VitestBrowserReact.render(<TodoInput.TodoInput />)

    let input = screen->VitestBrowserReact.getByPlaceholder(
      VitestBrowserLocator.String("Enter a todo..."),
    )
    await VitestBrowserUserEvent.fill(input, "Buy groceries")

    let addBtn = screen->VitestBrowserReact.getByRole("button", ~options={name: VitestBrowserLocator.String("Add")})
    await VitestBrowserUserEvent.click(addBtn)

    await VitestBrowserExpect.element(input)->VitestBrowserExpect.toHaveValue("")
  })

  testAsync("adds multiple todos", async _ => {
    let screen = await VitestBrowserReact.render(<TodoInput.TodoInput />)

    let input = screen->VitestBrowserReact.getByPlaceholder(
      VitestBrowserLocator.String("Enter a todo..."),
    )
    let addBtn = screen->VitestBrowserReact.getByRole("button", ~options={name: VitestBrowserLocator.String("Add")})

    await VitestBrowserUserEvent.fill(input, "Task 1")
    await VitestBrowserUserEvent.click(addBtn)

    await VitestBrowserUserEvent.fill(input, "Task 2")
    await VitestBrowserUserEvent.click(addBtn)

    await VitestBrowserUserEvent.fill(input, "Task 3")
    await VitestBrowserUserEvent.click(addBtn)

    let task1 = screen->VitestBrowserReact.getByText(VitestBrowserLocator.String("Task 1"))
    let task2 = screen->VitestBrowserReact.getByText(VitestBrowserLocator.String("Task 2"))
    let task3 = screen->VitestBrowserReact.getByText(VitestBrowserLocator.String("Task 3"))

    await VitestBrowserExpect.element(task1)->VitestBrowserExpect.toBeInTheDocument
    await VitestBrowserExpect.element(task2)->VitestBrowserExpect.toBeInTheDocument
    await VitestBrowserExpect.element(task3)->VitestBrowserExpect.toBeInTheDocument
  })

  testAsync("adds todo on Enter key press", async _ => {
    let screen = await VitestBrowserReact.render(<TodoInput.TodoInput />)

    let input = screen->VitestBrowserReact.getByPlaceholder(
      VitestBrowserLocator.String("Enter a todo..."),
    )
    await VitestBrowserUserEvent.fill(input, "Press Enter")
    await VitestBrowserUserEvent.keyboard("{Enter}")

    let todoItem = screen->VitestBrowserReact.getByText(VitestBrowserLocator.String("Press Enter"))
    await VitestBrowserExpect.element(todoItem)->VitestBrowserExpect.toBeInTheDocument
  })
})
