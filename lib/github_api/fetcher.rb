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
                        committedDate
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

      if results.errors.any?
        raise GraphQL::ExecutionError, results.errors.join(", ")
      else
        commits = results.data.repository.ref.target.history.edges

        if commits.length == 1
          assign_badge if commits.first.node.authoredByCommitter
          @project.update_column :last_commit, commits.first.node.committedDate
        end
      end
    end

    private

    def parse_github_link
      splitted = @project.github_link.split("/")
      return unless splitted.length > 2

      {owner: splitted[-2], repoName: splitted.last}
    end

    def assign_badge
      unless @project.mentee.badges.coder.any?
        @project.mentee.badges << Badge.coder
      end
    end
  end
end
