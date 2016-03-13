namespace :git_commits do
  desc "TODO"
  task update_last_commit: :environment do
   @projects = Project.all
    @projects.each do |project|
      next if project.github_link.nil?
      github_link_parts = []
      puts project.github_link
      github_link_parts = project.github_link.split('/')
      owner = github_link_parts[3]
      repo_name = github_link_parts[4]
      next if owner.nil? or repo_name.nil?
      if repo_name.include? ".git"
        repo_name = repo_name.match('^.*(?=(\.git))')[0]
      end
      puts owner, repo_name 
      github = Github.new basic_auth: 'login:password'
      repos= Github::Client::Repos.new  
      branches_info = {} 
      all_branches = repos.branches user: owner, repo: repo_name 
      if all_branches.empty?
          puts "no branches"
      else 
         all_branches.body.each do |branch| 
             branches_info["#{branch.name}".to_s] = "#{branch.commit.sha}" 
         end
      end 
      puts branches_info
      commits_list = []
      branches_info.each  do |branch, sha| 
        github = Github.new  
        commits = repos.commits.get owner, repo_name, sha 
        commits_list.push ( Time.parse(commits[:commit][:author][:date]))    
      end  
      project.last_commit = commits_list.max
      puts project.last_commit
    end
  end

end
