# Development Process

This document describes the commands used to create this project from scratch.

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
