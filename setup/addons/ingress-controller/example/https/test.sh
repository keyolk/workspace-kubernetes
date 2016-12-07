#!/bin/bash
INGRESS_NODE=`kubectl get po -l name=nginx-ingress-lb --template '{{range .items}}{{.spec.nodeName}}{{end}}' --namespace=kube-system`
curl -k https://$INGRESS_NODE/ -H 'Host: foo.bar.com'

