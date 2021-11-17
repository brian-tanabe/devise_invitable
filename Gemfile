source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

gemspec

group :test do
  platforms :jruby do
    gem 'activerecord-jdbcsqlite3-adapter'
  end

  platforms :ruby do
    gem 'sqlite3'
  end

  gem 'actionmailer'
  gem 'activerecord'
  gem 'capybara'
  gem 'devise'
  gem 'mocha'
  gem 'mongoid' # gem 'mongoid', github: 'mongoid/mongoid', branch: 'master'
  gem 'dynamoid'
  gem 'devise-dynamoid'
  gem 'nokogiri'
  gem 'rspec-rails'

  # https://github.com/minitest-reporters/minitest-reporters
  gem 'minitest-reporters'
end
