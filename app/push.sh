#!/bin/bash


# checks if branch has something pending
function parse_git_dirty() {
  git diff --quiet --ignore-submodules HEAD 2>/dev/null; [ $? -eq 1 ] && echo "*"
}

# gets the current git branch
function parse_git_branch() {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/\1$(parse_git_dirty)/"
}

function parse_git_hash() {
  git rev-parse --short HEAD
}

branch=$(parse_git_branch)
commit=$(parse_git_hash)

echo "Building with tag test/$branch-$commit"
docker build -t localhost:5000/test:$branch-$commit .

if [ $? == 0 ];
then
  docker push localhost:5000/test:$branch-$commit
fi


