#!/bin/bash

set -e


echo "Script deploying the infrastructure"

echo "Applying config"
kubectl apply -f ./app-configmap.yaml

echo "Deploying Xtest-app"
kubectl apply -f ./app-deployment.yaml
while [ $(kubectl get pod --no-headers | grep 'xtest' | grep -iv '1/1' | wc -l) -gt 0 ]; do
  echo 'App not ready yet';
  sleep 1;
done
