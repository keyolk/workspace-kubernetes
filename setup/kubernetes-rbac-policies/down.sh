#!/bin/bash

for yaml in `ls roles`
do
  kubectl delete -f roles/$yaml
done

for yaml in `ls rolebindings`
do
  kubectl delete -f rolebindings/$yaml
done
