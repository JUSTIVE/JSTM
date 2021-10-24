import * as React from "react"
import { graphql, PageProps } from "gatsby"

import Layout from "../components/Layout.gen"
import Seo from "../components/Seo.gen"

const NotFoundPage = ({ data, location }: PageProps<GatsbyTypes.NotFoundPageQuery>) => {
  const siteTitle = data.site?.siteMetadata.title ?? `Title`

  return (
    <Layout location={location} title={siteTitle}>
      <Seo title="404: Not Found" />
      <h1>404: Not Found</h1>
      <p>You just hit a route that doesn&#39;t exist... the sadness.</p>
    </Layout>
  )
}

export default NotFoundPage

export const pageQuery = graphql`
  query NotFoundPage {
    site {
      siteMetadata {
        title
      }
    }
  }
`
