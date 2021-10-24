%%raw(`import { graphql } from "gatsby";`)

%graphql(`
  query BioQuery {
    site {
      siteMetadata {
        author {
          name
          summary
        }
        social {
          twitter
        }
      }
    }
  }
`)

@react.component
let make = () => {
  let data: BioQuery.Raw.t = Gatsby.useStaticQuery(BioQuery.query)

  let site = switch Js.Nullable.toOption(data.site) {
  | None => Js.Exn.raiseError("Exception: site is not found")
  | Some(result) => result
  }

  let siteMetadata = site.siteMetadata
  let author = siteMetadata.author
  let social = siteMetadata.social
  <div>
    <ProfileImage />
    <div>
      {React.string("Written by")}
      {switch Js.Nullable.toOption(author.name) {
      | Some(name) => <strong> {React.string(name)} </strong>
      | None => React.null
      }}
      {switch Js.Nullable.toOption(author.summary) {
      | Some(summary) => <p> {React.string(summary)} </p>
      | None => React.null
      }}
      {React.string(" ")}
      {switch Js.Nullable.toOption(social.twitter) {
      | Some(twitter) =>
        <a href={`https://twitter.com/${twitter}`}>
          {React.string("You should follow them on Twitter")}
        </a>
      | None => React.null
      }}
    </div>
  </div>
}

@genType let default = make
