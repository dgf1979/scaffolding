#!/bin/bash

# GET PORJNAME FROM SCIRP ARGS
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
mkdir lib spec views public config public/css public/img

# README MD
echo ''
echo "downloading template README.md"
curl http://epicodus.drews.space/READMEs/epicodus_basic_unlicense/README.md > ./README.md

# CURL BASE URL
url=http://epicodus.drews.space/scaffolding/sinatra_activerecord
echo ''
echo 'downloading scaffolding files'
#Files
curl $url/Gemfile > ./Gemfile
curl $url/Rakefile > ./Rakefile
curl $url/app.rb > ./app.rb
curl $url/config.ru > ./config.ru
curl $url/lib/sample.rb > ./lib/sample.rb
curl $url/spec/sample_integration_spec.rb > ./spec/sample_integration_spec.rb
curl $url/spec/sample_spec.rb > ./spec/sample_spec.rb
curl $url/spec/spec_helper.rb > ./spec/spec_helper.rb
curl $url/views/layout.erb > ./views/layout.erb
curl $url/views/test.erb > ./views/test.erb
curl $url/config/database.yml > ./config/database.yml

#bundle
bundle install

# GIT
echo ''
echo "setting up Git.."
git init .
git config user.name Drew
git config user.email drew@finstrom.us
git add .

echo ''
echo "trying to set up git pair.."
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

# RSPEC CHECK
echo ''
echo "Checking with RSPEC.."
rspec

echo ''
here=$(pwd)
echo "$projname set up in: $here"
echo ''

# START PROJECT IN ATOM

atom .

exit 1
