#!/bin/bash

# accept version with -v 
while getopts "v:" opt; do
  case $opt in
    v) VER=$OPTARG;;
  esac
done

echo "deleting the old objects"
kubectl delete all --all

DIR=. # set the directory to the default

echo "applying k8s yaml files"

for file in "$DIR"/*.y*ml; do
    if [ -f "$file" ]; then
        echo "applying $file ..."
        # swap the <<VERSION>> in the YAML files with the passed version VER
        sed -i "s/<<VERSION>>/${VER}/" "$file" 
        kubectl apply -f "$file"
    else
        echo "no yaml files in : $DIR"
        break
    fi
done

echo -e "\nstarting pods ...\n"

kubectl rollout status all

kubectl rollout restart deployment/coredns --namespace=kube-system # restart coredns to avoid dns issues (pods can't recognize service names)

echo -e "\nkubectl get all :\n"
kubectl get all

echo "Note : if the app doesen't start wait for the pods to be ready"
