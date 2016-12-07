#!/bin/bash
kubectl create -f kubedns-svc.yaml
kubectl create -f kubedns-rc.yaml
