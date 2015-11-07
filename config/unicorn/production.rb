root = "/home/litg/current"
working_directory root

pid "#{root}/tmp/pids/unicorn.log"
stderr_path "#{root}/log/unicorn.log"
stdout_path "#{root}/log/unicorn.log"

listen '/tmp/unicorn.WebPlatform.sock', backlog: 64

before_exec do |_|
  ENV['BUNDLE_GEMFILE'] = File.join(root, 'Gemfile')
end
