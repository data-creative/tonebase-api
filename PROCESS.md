# Development Process

This document describes the commands used to create this project from scratch.

## Setup

Generate a new rails app:

```` sh
rails new tone_base --database=postgresql
cd tone_base/
````

Configure version control and deploy to remote repo:

```` sh
git init .
git commit -m "Generate new repo" # and some more commits
git remote add origin git@github.com:data-creative/tonebase-api.git
git pull origin master --allow-unrelated-histories # and resolve merge conflicts
git push origin master
````

Revise Gemfile to fit preferences and needs, then `bundle install`.

Configure documentation generator:

```` sh
bundle exec yard doc
````

Configure test suite and [factories](https://github.com/thoughtbot/factory_girl/blob/master/GETTING_STARTED.md#rspec):

```` sh
bundle exec rails generate rspec:install
````

```` rb
# spec/support/factory_girl.rb
RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
end
````

```` rb
# rails_helper
require 'support/factory_girl'
````

Create local databases:

```` sh
bundle exec rake db:create
````

Create new app called "tonebase-api" within the tonebase heroku organization. Then configure the heroku remote:

```` sh
heroku git:remote -a tonebase-api
````

## Development

```` sh
rails g model instrument name:string:uniq description:text
````
