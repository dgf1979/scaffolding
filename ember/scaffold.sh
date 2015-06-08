#!/bin/bash

# GET PROJNAME FROM SCRIPT ARGS
if [ $# -eq 0 ]; then
  echo "pass the project name at the end of the script, e.g. './scaffold.sh my_project_name'"
  exit 1
fi

# FOLDER STRUCTURE
projname=$1
echo ''
echo "Setting up project '$projname'"..
cd ~/Desktop
mkdir $projname
cd $projname
mkdir js img css js/lib css/lib
mkdir

# README MD
echo ''
echo "downloading template README.md"
curl http://epicodus.drews.space/READMEs/epicodus_basic_unlicense/README.md > ./README.md

# CURL BASE URL
url=http://epicodus.drews.space/scaffolding/ember

echo ''
echo 'downloading scaffolding files'

#bootstrap
curl https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css > ./css/lib/bootstrap.min.css
#jQuery
curl http://code.jquery.com/jquery-1.11.3.js > ./js/lib/jquery-1.11.3.js
#ember
curl http://builds.emberjs.com/release/ember-template-compiler.js > ./js/lib/ember-template-compiler.js
curl http://builds.emberjs.com/release/ember.debug.js > ./js/lib/ember.debug.js

curl $url/js/script.js > ./js/script.js
curl $url/css/style.css > ./css/style.css
curl $url/index.html > ./index.html
curl $url/server.sh > ./server.sh
curl $url/.eslintrc > ./.eslintrc

chmod +x server.sh

# GIT
echo ''
echo "setting up Git.."
git init .
git config user.name Drew Finstrom
git config user.email drew@finstrom.us
git add .

echo ''
echo "trying to set up git pair.. (package dependant)"
git pair add dgf Drew

# GIT REMOTE REPO
while true; do
  echo ''
  echo "Create a remote Github repo? ('https://github.com/dgf1979/epicodus-$projname')"
  read -p "y/n?" yn
  echo
  case $yn in
    [Yy]* ) curl -u dgf1979 https://api.github.com/user/repos -d '{"name":"epicodus-'$projname'"}';
            git remote add drew https://github.com/dgf1979/epicodus-$projname;
            break;;
    [Nn]* ) break;;
    * ) echo "y/n? ";;
  esac
done

echo ''
here=$(pwd)
echo "$projname set up in: $here"
echo ''

# START PROJECT IN ATOM

atom .

exit 1
