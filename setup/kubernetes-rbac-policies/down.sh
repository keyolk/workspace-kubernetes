#!/bin/bash

for yaml in `ls roles`
do
  kubectl delete -f roles/$yaml
done

for yaml in `ls bindings`
do
  kubectl delete -f bindings/$yaml
done
