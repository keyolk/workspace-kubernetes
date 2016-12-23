#!/bin/bash
kubectl create -f default-backend.yaml
kubectl expose rc default-http-backend --port=80 --target-port=8080 --name=default-http-backend
kubectl create -f rc-default.yaml
