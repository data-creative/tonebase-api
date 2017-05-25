
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

## Installation

Download the source code:

```` sh
git clone git@github.com:data-creative/tonebase-api.git
cd tonebase-api/
bundle install
````
