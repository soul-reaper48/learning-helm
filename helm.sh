#!/bin/bash

echo "--------------------------------------------Service Account and Role Binding--------------------------------------------------"

kubectl apply -f rbac-config-tiller.yaml

echo "---------------------------------------------------Initialize Tiller----------------------------------------------------------"

helm init --service-account tiller 
sleep 10

echo "---------------------------------------------------Installing a chart---------------------------------------------------------"

helm install --name grafana stable/grafana --set service.type=LoadBalancer

kubectl get secret --namespace default grafana -o jsonpath="{.data.admin-password}" | base64 --decode  > creds.txt
