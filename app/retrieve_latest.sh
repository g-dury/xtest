#!/bin/bash

if [ -z $1 ];
then
  image="ximage"
else
  image=$1
fi

if [ -z $2 ];
then
  registry="localhost:5000"
else
  registry=$2
fi

curl -s -X GET http://$registry/v2/$image/tags/list | jq '.tags | .[-1]'
