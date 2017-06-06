source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end # keep this here. https://stackoverflow.com/questions/41454333/meaning-of-new-block-git-sourcegithub-in-gemfile#

ruby "2.2.3"

gem 'rails', '~> 5.0.3' # Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'pg', '~> 0.18' # Use postgresql as the database for Active Record
gem 'puma', '~> 3.0' # Use Puma as the app server
gem 'jbuilder', '~> 2.5'

gem 'uglifier', '>= 1.3.0' # heroku needs this # Use Uglifier as compressor for JavaScript assets
# gem 'therubyracer', platforms: :ruby # See https://github.com/rails/execjs#readme for more supported runtimes
gem 'jquery-rails' # heroku needs this # dev webserver needs this # Use jquery as the JavaScript library # Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5' # heroku needs this # dev webserver needs this # Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder

gem 'yard', group: :doc # run `bundle exec yard doc` to parse comments and/or `bundle exec yard server` to view documentation at *localhost:8808*

gem 'rack-cors', :require => 'rack/cors' # enable cross-origin requests

group :development, :test do
  gem 'pry'

  gem 'rspec-rails', '~> 3.5'
  gem 'factory_girl_rails', '~> 4.0'
  gem 'shoulda-matchers', '~> 3.1'
end

group :development do
  gem 'listen', '~> 3.0.5' # dev webserver needs this
  gem "rails-erd" # Run `rails generate erd:install`, then database migrations will trigger a new diagram.
end
