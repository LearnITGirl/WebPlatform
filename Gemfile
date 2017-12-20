source 'https://rubygems.org'

ruby '2.3.0'

gem 'rails', '4.2.6'
gem 'dry-validation'

gem 'pg'
gem 'unicorn'

gem 'rails_admin', '~> 1.2'

gem 'mini_magick'
gem 'carrierwave'
gem 'file_validators'
gem "fog"

gem 'virtus'

gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'
gem 'slim-rails'
gem 'simple_form'

gem 'jquery-rails'

gem 'dotenv-rails'

gem 'sorcery'

gem 'bower-rails', '~> 0.10.0'

gem 'carmen-rails'

gem 'font-awesome-sass'

gem 'gibbon', git: 'git://github.com/amro/gibbon.git'

gem 'rollbar'
gem 'data-confirm-modal', github: 'ifad/data-confirm-modal'

gem 'spreadsheet'

gem 'react-rails'
gem 'react_component'

gem 'graphql-client', '~> 0.8.6'

group :development, :test do
  gem 'pry-rails'
	gem 'letter_opener'
	gem 'rails_best_practices', '~> 1.19'
end

group :test do
  gem 'capybara'
  gem 'database_cleaner'
	gem 'rspec-rails', '~> 3.6'
	gem 'simplecov', '~> 0.15.1'
  gem 'selenium-webdriver', '2.45.0'
  gem 'factory_girl_rails'
  gem 'fabrication'
  gem 'faker' , '~> 1.8.4'
end

group :production, :staging do
  gem 'rails_12factor'
  gem 'rails_stdout_logging'
end

group :development do
  gem 'capistrano', '~> 3.4.0'
  gem 'capistrano-rvm'
  gem 'capistrano-rails'
  gem 'capistrano-bundler'
  gem 'capistrano3-unicorn'
end
