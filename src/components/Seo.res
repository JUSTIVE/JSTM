%%raw(`import { graphql } from "gatsby";`)

%graphql(`
  query SeoQuery {
    site {
      siteMetadata {
        title
        description
        social {
          twitter
        }
      }
    }, 
  }
`)

@react.component
let make = (
  ~description: option<string>=?,
  ~lang: option<string>=?,
  ~title: option<string>=?,
  ~meta: option<array<ReactHelmet.htmlMetadata>>=?,
) => {
  let data: SeoQuery.Raw.t = Gatsby.useStaticQuery(SeoQuery.query)
  let site = switch Js.Nullable.toOption(data.site) {
  | Some(result) => result
  | None => Js.Exn.raiseError("Exception: site is not found")
  }
  let lang = switch lang {
    | Some(result) => result
    | None => "en"
  }
  let title = switch title {
    | Some(result) => result
    | None => ""
  }
  let titleTemplate = switch Js.Nullable.toOption(site.siteMetadata.title) {
  | Some(defaultTitle) => `%s | ${defaultTitle}`
  | None => title
  }

  let metaDescription = switch description {
  | Some(result) => result
  | None =>
    switch Js.Nullable.toOption(site.siteMetadata.description) {
    | Some(result) => result
    | None => ""
    }
  }

  let defaultMeta = [
    ReactHelmet.NamedMetadata({
      name: "description",
      content: metaDescription,
    }),
    ReactHelmet.RdfMetadata({
      property: `og:title`,
      content: title,
    }),
    ReactHelmet.RdfMetadata({
      property: `og:description`,
      content: metaDescription,
    }),
    ReactHelmet.RdfMetadata({
      property: `og:type`,
      content: `website`,
    }),
    ReactHelmet.NamedMetadata({
      name: `twitter:card`,
      content: `summary`,
    }),
  ]
  let meta = Belt.Array.concat(
    defaultMeta,
    switch meta {
    | Some(result) => result
    | None => []
    },
  )

  <ReactHelmet.Helmet htmlAttributes={{lang: lang}} title titleTemplate meta />
}

@genType let default = make
