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

Configure test suite and [factories](https://github.com/thoughtbot/factory_girl/blob/master/GETTING_STARTED.md#rspec) and [matchers](https://github.com/thoughtbot/shoulda-matchers):

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
# spec/rails_helper.rb
require 'support/factory_girl'

# RSpec.configure do |config|
  # ...

  # Configure Shoulda Matchers
  Shoulda::Matchers.configure do |config|
    config.integrate do |with|
      with.test_framework :rspec

      with.library :rails
    end
  end
# end
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
rails g model advertiser name:string:uniq description:text url:string
rails g model ad advertiser:references title:string content:text url:string image_url:string
rails g model ad_placement ad:references start_date:date end_date:date price:integer
rails g model ad_instrument ad:references instrument:references

rails g model user email:string:uniq password:string confirmed:boolean visible:boolean role:string access_level:string first_name:string last_name:string bio:text image_url:string hero_url:string
rails g model user_followship user:references followed_user_id:integer

rails g model video user:references instrument:references title:string description:text tags:text
rails g model user_favorite_video user:references video:references

rails g model user_profile user:references birth_year:integer professions:text
rails g model user_music_profile user:references guitar_owned:boolean guitar_models_owned:text fav_composers:text fav_performers:text fav_periods:text

rails g model video_part video:references source_url:string number:integer duration:integer
rails g model video_score video:references image_url:string starts_at:integer ends_at:integer

rails g model user_view_video user:references video:references

rails g model announcement title:string content:text url:string image_url:string
````
