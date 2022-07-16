#!/usr/bin/env bash

# This tags and uploads an image to Docker Hub

# Step 1:
# This is your Docker ID/path
dockerpath=dungtnt2244/ml-app

# Step 2
# Run the Docker Hub container with kubernetes
r=$(kubectl get pod ml-app 2> /dev/null;echo $?)

if [ "_$r" == "_1" ] ; then
    kubectl run ml-app \
    --image=$dockerpath \
    --image-pull-policy="Always" \
    --overrides='{"apiVersion": "v1", "spec":{"imagePullSecrets": [{"name": "regcred"}]}}'
fi

# Step 3:
# List kubernetes pods
kubectl get pods

# Step 4:
# Forward the container port to a host
kubectl port-forward ml-app 8000:80