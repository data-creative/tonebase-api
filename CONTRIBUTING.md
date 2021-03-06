
# Contributor's Guide

This document describes the process of setting up a local development environment on Mac OS X.

## Prerequisites

Install the [Homebrew](https://brew.sh/) package manager, if necessary:

```` sh
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
````

Install the PostgreSQL database management system, if necessary:

```` sh
brew install postgresql
brew services start postgresql
createdb
````

Install the Ruby language (version 2.2.3), if necessary:

```` sh
brew install rbenv
rbenv install 2.2.3
rbenv global 2.2.3
````

Install the Bundler and Rails command line utilities, if necessary:

```` sh
gem install bundler
gem install rails
````

Setup environment variable(s) in your profile:

    export TONEBASE_CLIENT_TOKEN="abc123" # shared with client application and excluded from version control

## Installation

Download the source code:

```` sh
git clone git@github.com:data-creative/tonebase-api.git
cd tonebase-api/
bundle install
````

## Setup Database

Setup the database:

```` sh
bin/rake db:setup
````

Seed the database:

```` sh
bin/rake db:seed
````

Migrate the database, if necessary:

```` sh
bin/rake db:migrate
````

## Developing

Run a local web server:

```` sh
bin/rails s
````

Run a local rails console:

```` sh
bin/rails c
````

## Testing

Run tests:

```` sh
bundle exec rspec spec/
````

## Deploying

Gain access to the Heroku application called "tonebase-api", then deploy when ready:

```` sh
git pull origin master
git push origin master
git push heroku master
````

If deploying for the first time, seed the production database:

```` sh
heroku run "bin/rake db:seed"
````

If the changes require a database migration, run:

```` sh
heroku run "bin/rake db:migrate"
````
