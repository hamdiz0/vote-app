#!/bin/bash

echo "deleteing the old objects"
minikube kubectl -- delete all --all

# accept version with -v 
while getopts "v:" opt; do
  case $opt in
    v) VER=$OPTARG;;
  esac
done

DIR=. # set the directory to the default

echo "applying k8s yaml files"

for file in "$DIR"/*.y*ml; do
    if [ -f "$file" ]; then
        echo "applying $file ..."
        sed -i "s/<<VERSION>>/${VER}/" "$file" # swap the <<VERSION>> in the YAML files with the passed version VER
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


# terminate old forwarding process to avoid conflicts
kill $(ps aux | grep 'kubectl port-forward' | awk '{print $2}')
# forward ports to the host machine
minikube kubectl -- port-forward svc/vote-svc 30000:80 --address 0.0.0.0 &
minikube kubectl -- port-forward svc/result-svc 30001:80 --address 0.0.0.0 &

echo "Note : if the app doesen't start wait for the pods to be ready"

