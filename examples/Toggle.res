/**
 * Toggle — An example component demonstrating conditional rendering
 * and checkbox interactions.
 *
 * A labeled checkbox that shows/hides a content section when toggled.
 */

module Toggle = {
  @react.component
  let make = (~label="Show content", ~children=React.null) => {
    let (isOpen, setIsOpen) = React.useState(() => false)

    <div>
      <label>
        <input
          type_="checkbox"
          checked=isOpen
          onChange={e => {
            let checked = (e->ReactEvent.Form.target)["checked"]
            setIsOpen(_ => checked)
          }}
        />
        {React.string(label)}
      </label>
      {isOpen ? <div> {children} </div> : React.null}
    </div>
  }
}
