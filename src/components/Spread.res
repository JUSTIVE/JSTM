@react.component
let make = (~props, ~children) => React.cloneElement(children, props)

@genType let default = make
