#!/bin/bash

for yaml in `ls roles`
do
  kubectl create -f roles/$yaml
done

for yaml in `ls bindings`
do
  kubectl create -f bindings/$yaml
done
