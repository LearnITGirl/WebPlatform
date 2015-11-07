set :port, 22
set :user, 'litg'
set :deploy_via, :remote_cache
set :use_sudo, false
set :branch, :production
set :tmp_dir, "/home/#{fetch(:user)}/tmp"

server 'learnitgirl.com',
  roles: [:web, :app, :db],
  port: fetch(:port),
  user: fetch(:user),
  primary: true

set :deploy_to, "/home/#{fetch(:user)}"

set :ssh_options, {
  forward_agent: true,
  user: fetch(:user),
  auth_methods: %w(publickey),
  keys: %w(~/.ssh/id_rsa.pub)
}

set :rails_env, :production
set :conditionally_migrate, true
