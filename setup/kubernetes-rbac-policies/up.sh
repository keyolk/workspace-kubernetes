#!/bin/bash

for yaml in `ls roles`
do
  kubectl create -f roles/$yaml
done

for yaml in `ls rolebindings`
do
  kubectl create -f rolebindings/$yaml
done
