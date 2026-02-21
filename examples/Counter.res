/**
 * Counter — A simple example component demonstrating state management
 * and click interactions.
 *
 * Renders increment/decrement buttons and displays the current count.
 */
module Counter = {
  @react.component
  let make = () => {
    let (count, setCount) = React.useState(() => 0)

    <div>
      <p> {`Count: ${count->Int.toString}`->React.string} </p>
      <button onClick={_ => setCount(prev => prev + 1)}> {React.string("Increment")} </button>
      <button onClick={_ => setCount(prev => prev - 1)}> {React.string("Decrement")} </button>
    </div>
  }
}
