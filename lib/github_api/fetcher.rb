module GithubAPI
  class Fetcher
    class QueryError < StandardError; end

    def initialize(project)
      @project = project
    end

    CommitsQuery = GithubAPI::Client.parse <<-'GRAPHQL'
      query($owner: String!, $repoName: String!) {
        repository(owner: $owner, name: $repoName) {
          ref(qualifiedName: "master") {
            target {
              ... on Commit {
                committedDate
                  history(first: 1) {
                    edges {
                      node {
                        oid
                        messageHeadline
                        authoredByCommitter
                      }
                    }
                  }
                }
              }
            }
          }
        }
    GRAPHQL

    def check_latest_commit
      results = GithubAPI::Client.query(CommitsQuery, variables: {owner: "Powerglove", repoName: "Thinkerinnen"})
      if results.errors.any?
        raise QueryError.new(response.errors[:data].join(", "))
      else
        commits = results.data.repository.ref.target.history.edges
        assign_badge if commits.length == 1 && commits.first.node.authoredByCommitter
      end
    end
  end
end
