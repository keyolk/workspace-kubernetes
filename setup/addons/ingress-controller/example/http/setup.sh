#!/bin/bash
kubectl run echoheaders --image=gcr.io/google_containers/echoserver:1.4 --replicas=1 --port=8080

kubectl expose deployment echoheaders --port=80 --target-port=8080 --name=echoheaders-x
kubectl expose deployment echoheaders --port=80 --target-port=8080 --name=echoheaders-y

kubectl create -f ingress.yaml
