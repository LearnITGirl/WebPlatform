namespace :git_commits do
  desc "TODO"
  task update_last_commit: :environment do
   @projects = Project.all
    @projects.each do |project|
      next if project.github_link.nil?
      gitvalues = parse_orgname_reponame(project.github_link)
      owner = gitvalues[0]
      repo_name = gitvalues[1]
      next if owner.nil? or repo_name.nil?
      #puts owner, repo_name

      begin
        repos= Github::Client::Repos.new :client_id => 'c1e144121ec161136a4a', :client_secret => 'cf3290b0f2524e5e5e34e8cd0c6c29d48d9d58f1', :oauth_token => 'be324e907d1fc1c1b0a7081ce2d8cc8b160a19ac'  
      
        branches_info = {} 
        all_branches = repos.branches user: owner, repo: repo_name 
        puts "ratelimit", all_branches.headers.ratelimit_remaining
        if all_branches.empty?
          puts "no branches/commit"
        elsif all_branches.success? 
          all_branches.body.each do |branch|
             branches_info["#{branch.name}".to_s] = "#{branch.commit.sha}"
          end
          puts branches_info
          commits_list = []
          branches_info.each  do |branch, sha|
            commits = repos.commits.get owner, repo_name, sha
            commits_list.push ( Time.parse(commits[:commit][:author][:date]))
          end
          project.update_attributes(last_commit: commits_list.max)
          puts project.last_commit
        else 
           puts "redirection url", all_branches.url
        end
      rescue Github::Error::GithubError => e
         puts e.message

         if e.is_a? Github::Error::ServiceError
            # handle GitHub service errors such as 404
         elsif e.is_a? Github::Error::ClientError
            # handle client errors e.i. missing required parameter in request
         end
      end
    end
  end
  private

  def parse_orgname_reponame(github_link)
      github_link_parts = []
      puts github_link
      github_link_parts = github_link.split('/')
      owner = github_link_parts[3]
      repo_name = github_link_parts[4]
      if !repo_name.nil? and repo_name.include? ".git"
        repo_name = repo_name.match('^.*(?=(\.git))')[0]
      end
      gitname = []
      gitname.push(owner)
      gitname.push(repo_name)
      return gitname
  end
end
