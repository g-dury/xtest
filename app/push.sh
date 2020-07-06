#!/bin/bash

# gets the current git branch
function parse_git_branch() {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/\1/"
}

function parse_git_hash() {
  git rev-parse --short HEAD
}

branch=$(parse_git_branch)
commit=$(parse_git_hash)
timestamp=`date +%s`
image="ximage"

echo "Building with tag $image/$timestamp-$branch-$commit"
docker build -t localhost:5000/$image:$timestamp-$branch-$commit .

if [ $? == 0 ];
then
  docker push localhost:5000/$image:$timestamp-$branch-$commit
fi


