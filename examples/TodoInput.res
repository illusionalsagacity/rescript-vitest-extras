/**
 * TodoInput — An example component demonstrating form inputs and list rendering.
 *
 * A text input field with an "Add" button that accumulates todo items in a list.
 * The button is disabled when the input is empty.
 */
module TodoInput = {
  @react.component
  let make = () => {
    let (input, setInput) = React.useState(() => "")
    let (todos, setTodos) = React.useState(() => [])

    let handleAdd = () => {
      if input->String.length > 0 {
        setTodos(todos => [input, ...todos])
        setInput(_ => "")
      }
    }

    let handleKeyDown = e => {
      if e->ReactEvent.Keyboard.key == "Enter" {
        handleAdd()
      }
    }

    <div>
      <input
        type_="text"
        placeholder="Enter a todo..."
        value=input
        onChange={e => {
          let value = (e->ReactEvent.Form.target)["value"]
          setInput(_ => value)
        }}
        onKeyDown=handleKeyDown
      />
      <button onClick={_ => handleAdd()} disabled={input->String.length == 0}>
        {React.string("Add")}
      </button>
      <ul>
        {todos
        ->Array.mapWithIndex((todo, i) => {
          <li key={i->Int.toString}> {React.string(todo)} </li>
        })
        ->React.array}
      </ul>
    </div>
  }
}
