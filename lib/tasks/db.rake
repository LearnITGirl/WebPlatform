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

  task count_rows: :environment do
    x=[]
    ActiveRecord::Base.connection.tables
      .each {|t| x << {name: t, result: ActiveRecord::Base.connection.execute("SELECT count(*) from #{t}")}}

    x.each{|r| r[:result].each {|z| p "#{r[:name]} - #{z.map{|k,v| v}.max}"}}
  end

  task clean_actual_edition_data: :environment do
    input = ''
    STDOUT.puts "Are you sure? Type: 'yes I am' If you already backup DB and You want to delete all data"
    input = STDIN.gets.chomp

    return puts "Backup database and try again" unless input == "yes I am"

    ActiveRecord::Base.transaction do
      Evaluation.delete_all
      FinalSurvey.delete_all
      MenteeApplication.delete_all
      MentorApplication.delete_all
      MenteeMidtermEvaluation.delete_all
      MentorMidtermEvaluation.delete_all
      Poll.delete_all
      Newsletter.delete_all
      Project.delete_all
      Task.delete_all
      ApplicationMatch.delete_all
      User.where.not(role: 1).delete_all

      puts "Database clear"
    end
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
