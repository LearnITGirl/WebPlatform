namespace :db do

  task :dump_heroku do
    dump_production
  end

  task :restore_development do
    restore_localy
  end

  task :copy_production_to_localhost do
    dump_production
    restore_localy
  end

  private

  def dump_production
    Bundler.with_clean_env {sh "heroku pg:backups capture --app learn-it-girl-production"}
    Bundler.with_clean_env {sh "curl -o ./tmp/postgres.dump `heroku pg:backups public-url --app learn-it-girl-production`"}
  end

  def restore_localy
    system "pg_restore --verbose --clean --no-acl --no-owner -h localhost -d learn_it_girl_development ./tmp/postgres.dump"
  end

end
