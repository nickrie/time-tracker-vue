#!/usr/bin/env sh

# This file is based on instructions at:
#   https://cli.vuejs.org/guide/deployment.html#github-pages

# abort on errors
set -e

# build
npm run build

# navigate into the build output directory
cd dist

git init
git add -A
git commit -m 'deploy'

# if you are deploying to https://<USERNAME>.github.io/<REPO>
git push -f git@github.com:nickrie/time-tracker-vue.git master:gh-pages
