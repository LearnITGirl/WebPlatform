# Set up gems listed in the Gemfile.
#So first it resolves the parent of __FILE__,
#that is config/, then go to the parent, the root of the project and appends 'Gemfile'
ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../Gemfile', __FILE__)

require 'bundler/setup' if File.exists?(ENV['BUNDLE_GEMFILE'])
