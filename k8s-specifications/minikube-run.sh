#!/bin/bash

VER="latest" #default the version to latest

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

# port forwarding to access the service 
minikube kubectl -- port-forward svc/vote-svc 30000:80 --address 0.0.0.0 &  # & to run in the background
# get port forwarding proccess id
VOTE_PID=$!

minikube kubectl -- port-forward svc/result-svc 30001:80 --address 0.0.0.0 &
# get port forwarding proccess id
RESULT_PID=$!

# if you don't disown the forwarding process the script will stay in an execution state and the jenkins build wont end

disown $VOTE_PID
disown $RESULT_PID

echo "port forwarding started for vote-svc on 30000 and result-svc on 30001."
