namespace :git_commits do
  desc "TODO"
  task update_last_commit: :environment do
    @projects = Project.all
    @projects.each do |project|
      next if project.github_link.empty? 
      github_link_parts = []
      github_link_parts = project.github_link..split('/')
      owner = github_link_parts[3]
      repo_name= github_link_parts[4]
      next if owner.is_nil? || repo_name.is_nil? 
      repos= Github::Client::Repos.new
      branches_info = {} 
      all_branches = repos.branches user: owner, repo: repo_name 
      all_branches.body.each do |branch| 
        branches_info["#{branch.name}".to_s] = "#{branch.commit.sha}" 
      end 

      commits_list = []
      branches_info.each  do |branch, sha| 
        github = Github.new  
        commits = repos.commits.get owner, repo_name, sha 
        commits_list.push ( Time.parse(commits[:commit][:author][:date]))    
      end  
      project.last_commit = commits_list.max
    end
  end

end
