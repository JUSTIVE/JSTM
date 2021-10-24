type imageLayout = [#fixed | #fullWidth | #constrained]
type imageFormat = [#jpg | #png | #webp | #avif | #auto]

module StaticImage = {
  @module("gatsby-plugin-image") @react.component
  external make: (
    ~children: React.element=?,
    ~className: string=?,
    ~layout: imageLayout=?,
    ~formats: array<imageFormat>=?,
    ~src: string=?,
    ~width: int=?,
    ~height: int=?,
    ~quality: int=?,
    ~alt: string=?,
  ) => React.element = "StaticImage"
}
