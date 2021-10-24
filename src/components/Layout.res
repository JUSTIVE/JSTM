@val external __PATH_PREFIX__: string = "__PATH_PREFIX__"

@react.component
let make = (~title: string, ~location: Gatsby.location, ~children: React.element) => {
  let rootPath = __PATH_PREFIX__ ++ "/"
  let isRootPath = location.pathname == rootPath

  let header = if isRootPath {
    <h1 className="main-heading"> <Gatsby.Link _to="/"> {React.string(title)} </Gatsby.Link> </h1>
  } else {
    <Gatsby.Link className="header-link-home" _to="/"> {React.string(title)} </Gatsby.Link>
  }

  <Spread props={"data-is-root-path": isRootPath}>
    <div className="global-wrapper">
      <header className="global-header"> {header} </header>
      <main> {children} </main>
      <footer>
        {React.string(Js.Date.make()->Js.Date.getFullYear->Js.Float.toString ++ ", Built with ")}
        <a href="https://www.gatsbyjs.com"> {React.string("Gatsby")} </a>
      </footer>
    </div>
  </Spread>
}

@genType let default = make
