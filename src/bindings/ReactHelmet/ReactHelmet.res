type htmlMetadata =
  | @unboxed NamedMetadata({name: string, content: string})
  | @unboxed RdfMetadata({property: string, content: string})

type htmlAttributes = {lang: string}

module Helmet = {
  @module("react-helmet") @react.component
  external make: (
    ~htmlAttributes: htmlAttributes=?,
    ~title: string=?,
    ~titleTemplate: string=?,
    ~meta: array<htmlMetadata>=?,
  ) => React.element = "Helmet"
}
