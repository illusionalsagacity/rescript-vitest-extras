/**
 * UseCounter — A simple custom hook example for testing `renderHook`.
 */
type counterState = {
  count: int,
  increment: unit => unit,
  decrement: unit => unit,
}

let useCounter = (~initial=0) => {
  let (count, setCount) = React.useState(() => initial)
  {
    count,
    increment: () => setCount(prev => prev + 1),
    decrement: () => setCount(prev => prev - 1),
  }
}
