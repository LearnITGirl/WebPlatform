worker_processes Integer(ENV["WEB_CONCURRENCY"] || 4)
timeout 15
preload_app true

if Rails.env.production?
  root "/home/litg/current"
  working_directory root

  pid "#{root}/tmp/pids/unicorn.log"
  stderr_path "#{root}/log/unicorn.log"
  stdout_path "#{root}/log/unicorn.log"

  listen '/tmp/unicorn.WebPlatform.sock', backlog: 64

  before_exec do |_|
      ENV['BUNDLE_GEMFILE'] = File.join(root, 'Gemfile')
  end
end

before_fork do |server, worker|
  Signal.trap 'TERM' do
    puts 'Unicorn master intercepting TERM and sending myself QUIT instead'
    Process.kill 'QUIT', Process.pid
  end

  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.connection.disconnect!
end

after_fork do |server, worker|
  Signal.trap 'TERM' do
    puts 'Unicorn worker intercepting TERM and doing nothing. Wait for master to send QUIT'
  end

  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.establish_connection
end
