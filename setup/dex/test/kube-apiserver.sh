token="eyJhbGciOiJSUzI1NiIsImtpZCI6ImFlNTFmOGVjZTljNzExMGEyZTY0ZjljZGYyMWYzNzQ0ZTdkZTA4NjgifQ.eyJpc3MiOiJodHRwczovL2RleC5sb2NhbC5pbzo1NTU0L2RleCIsInN1YiI6IjEwODIyMTEzNTA1NzI2ODAyOTczMiIsImF1ZCI6ImV4YW1wbGUtYXBwIiwiZXhwIjoxNDc5OTM1ODY4LCJpYXQiOjE0Nzk4NDk0NjgsImVtYWlsIjoia2V5b2xrQGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJuYW1lIjoi7KCV7LCs7ZuIIn0.YDoUJg5dzCel-lBWlXnQPBj1tStvnFmehqLWs-XXLPRDT5vZZk-NtkxcuD8CLl8l2jQKExJUiR2nSVTGASZuwoEhjFh0YpZPzWzKX9m9-1wixRjagWLwk0jvv2KTkSFD9IBU8smzsAaK98vr5Y3KvvcQGJLGXSQJ1UGgnvkykfQsahsZW9zHiDjUNDXb5bOXsTqLeBibggwAdBzbmGTTi5Cu28Cy11QDzLXKHaC7dFJSZT1mHtACKJdpqR6dPsn-75R0RnI37TRJT3TbdO19xwf5cUsEXxV85ohLRizc_eVs8pDq8YVlZbOb1DEIbL15OcpmMYwqiyYCHmgN-qut0g"

curl -H "Authorization: Bearer $token" -k https://kube-apiserver.local.io:443/api/v1/nodes

kubectl config set-cluster vagrant-dex \
  --server=https://kube-apiserver.local.io \
  --certificate-authority=/opt/kubernetes/pki/kube-ca.pem

kubectl config set-credentials keyolk-dex \
  --token=$token

kubectl config set-context vagrant-dex --cluster=vagrant-dex --user=keyolk-dex --namespace=default
kubectl config use-context vagrant-dex

kubectl get node

