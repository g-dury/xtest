#!/bin/bash

#usage is opt 
# ./push BRANCH COMMIT HOST_REGISTRY

# gets the current git branch
function parse_git_branch() {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/\1/"
}

function parse_git_hash() {
  git rev-parse --short HEAD
}

if [ -z $1 ];
then
  branch=$(parse_git_branch)
else
  branch=$1
fi

if [ -z $2 ];
then
  commit=$(parse_git_hash)
else
  commit=$2
fi

if [ -z $3 ];
then
  registry="localhost:5000"
else
  registry=$3
fi

timestamp=`date +%s`
image="ximage"

echo "Building with tag $image/$timestamp-$branch-$commit"
docker build -t $registry/$image:$timestamp-$branch-$commit .

if [ $? == 0 ];
then
  docker push $registry/$image:$timestamp-$branch-$commit
fi


