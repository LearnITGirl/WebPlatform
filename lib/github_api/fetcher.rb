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
      params = parse_github_link
      return unless params

      results = GithubAPI::Client.query(CommitsQuery, variables: params)

      unless results.errors.any?
        commits = results.data.repository.ref.target.history.edges
        assign_badge if commits.length == 1 && commits.first.node.authoredByCommitter
      end
    end

    private

    def parse_github_link
      match = @project.github_link.match(GITHUB_REGEXP)
      return unless match

      {owner: match[3], repoName: match[4]}
    end

    def assign_badge
      unless @project.mentee.badges.coder.any?
        @project.mentee.badges << Badge.coder
      end
    end
  end
end
