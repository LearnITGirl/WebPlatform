namespace :github do

  desc "Pull latest commit info from github repo"
  task latest_commit: :environment do
    Project.current_edition.each do |project|
      next unless project.github_link.present?

      fetcher = GithubAPI::Fetcher.new(project)
      fetcher.check_latest_commit
    end
  end
end
