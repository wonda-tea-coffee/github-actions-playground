#/bin/bash

GITHUB_REPOSITORY=wonda-tea-coffee/github-actions-playground
LAST_WEEK=$(date --date='7 days ago' +%Y-%m-%d)
SEARCH_QUERY="repo:$GITHUB_REPOSITORY is:open created:>=$LAST_WEEK"

gh api graphql -f query="
  {
    search(query: \"$SEARCH_QUERY\", type: DISCUSSION, first: 100) {
      edges {
        node {
          ... on Discussion {
            url
          }
        }
      }
    }
  }" | \
  # jqですよ
  jq -r '.data.search.edges[].node.url'
