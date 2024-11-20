#!/bin/bash

echo "deleteing the old objects"
kubectl delete all --all

DIR=${1:-.}

echo "applying k8s yaml files"

for file in "$DIR"/*.y*ml; do
    if [ -f "$file" ]; then
        echo "applying $file ..."
        kubectl apply -f "$file"
    else
        echo "no yaml files in : $DIR"
        break
    fi
done

echo -e "\nstarting pods ...\n"

kubectl rollout status all

kubectl rollout restart deployment/coredns --namespace=kube-system

echo -e "\nkubectl get all :\n"
kubectl get all

echo "Note : if the app doesen't start wait for the pods to be ready"
