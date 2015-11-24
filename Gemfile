source 'https://rubygems.org'

ruby '2.2.2'

gem 'rails', '4.2.1'

gem 'pg'
gem 'unicorn'


gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'
gem 'slim-rails'

gem 'jquery-rails'

gem 'dotenv-rails'

gem 'sorcery'

gem 'bower-rails', '~> 0.10.0'

gem 'wicked'
gem 'carmen-rails'

gem 'font-awesome-sass'

gem 'gibbon', git: 'git://github.com/amro/gibbon.git'

group :development, :test do
  gem 'pry-rails'
  gem 'letter_opener'
end

group :test do
  gem 'capybara'
  gem 'database_cleaner'
  gem 'rspec-rails', '~> 3.0'
  gem 'selenium-webdriver', '2.45.0'
  gem 'factory_girl_rails'
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
