open GatsbyImage.Fragments

%%raw(`import { graphql } from "gatsby";`)

%graphql(`
  query ProfileImageQuery {
    avatar: file(absolutePath: { regex: "/profile-pic.png/" }) {
      childImageSharp {
        fixed(width: 72, height: 72) {
          ...GatsbyImageSharpFixed
        }
      }
    }
  }
`)

@react.component
let make = () => {
  let data: ProfileImageQuery.Raw.t = Gatsby.useStaticQuery(ProfileImageQuery.query)

  switch Js.Nullable.toOption(data.avatar) {
  | Some(avatar) =>
    switch Js.Nullable.toOption(avatar.childImageSharp) {
    | Some(childImageSharp) =>
      switch Js.Nullable.toOption(childImageSharp.fixed) {
      | Some(fixed) => <GatsbyImage fixed className="bio-avatar" />
      | None => React.null
      }
    | None => React.null
    }
  | None => React.null
  }
}

@genType let default = make
