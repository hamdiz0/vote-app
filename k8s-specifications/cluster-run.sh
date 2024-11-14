#!/bin/bash

echo "deleteing the old objects"
minikube kubectl -- delete all --all

DIR=${1:-.}

echo "applying k8s yaml files"

for file in "$DIR"/*.y*ml; do
    if [ -f "$file" ]; then
        echo "applying $file ..."
        minikube kubectl -- apply -f "$file"
    else
        echo "no yaml files in : $DIR"
        break
    fi
done

echo -e "\nstarting pods ...\n"

minikube kubectl -- rollout status all

echo -e "\nkubectl get all :\n"
minikube kubectl -- get all
echo -e "\nvote-url:\n"
minikube service -- vote-svc --url
echo -e "\nresult-url:\n"
minikube service -- result-svc --url

echo "Note : if the app doesen't start wait for the pods to be ready"

