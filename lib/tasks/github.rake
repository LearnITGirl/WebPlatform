namespace :github do

  desc "Pull latest commit info from github repo"
  task latest_commit: :environment do
    Project.current_edition.each do |project|
      next unless project.github_link.present?

      begin
        fetcher = GithubAPI::Fetcher.new(project)
        fetcher.check_latest_commit
      rescue GraphQL::ExecutionError => e
        Rollbar.error(e, "Obtaining Github commits with GraphQL failed for project id #{project.id}")
        next
      end
    end
  end

  desc "Send email if github link is invalid/missing"
  task check_repos: :environment do
    Project.current_edition.each do |project|
      if project.github_link.blank? || invalid_repo?(project)
        mentee_template = EmailTemplate.missing_invalid_github_link_mentees.first
        mentor_template = EmailTemplate.missing_invalid_github_link_mentors.first

        EmailTemplateMailer.custom(mentee_template, project.mentee).deliver_now
        EmailTemplateMailer.custom(mentor_template, project.mentor).deliver_now
      end
    end
  end

  private

  def invalid_repo?(project)
    begin
      fetcher = GithubAPI::Fetcher.new(project)
      !fetcher.repo_exists?
    rescue GraphQL::ExecutionError => e
      Rollbar.error(e, 'Obtaining Github commits with GraphQL failed')
    end
  end
end
