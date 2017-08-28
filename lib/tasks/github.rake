namespace :github do

  desc "Pull latest commit info from github repo"
  task latest_commit: :environment do
    Project.current_edition.each do |project|
      next unless project.github_link.present?

      begin
        fetcher = GithubAPI::Fetcher.new(project)
        fetcher.check_latest_commit
      rescue GraphQL::ExecutionError => e
        Rollbar.error(e, 'Obtaining Github commits with GraphQL failed')
        next
      end
    end
  end
end
