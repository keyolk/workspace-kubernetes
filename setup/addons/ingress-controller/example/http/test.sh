#!/bin/bash
INGRESS_NODE=`kubectl get po -l name=nginx-ingress-lb --template '{{range .items}}{{.spec.nodeName}}{{end}}' --namespace=kube-system`
curl $INGRESS_NODE/foo -H 'Host: foo.bar.com'

