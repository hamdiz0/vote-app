# Vote-App

<a href="https://github.com/dockersamples/example-voting-app">Based on example-voting-app</a>

* This app is structured into five services, each running in separate containers, and it allows users to cast votes and see results in real-time.
* This porject also includes a Kubernetes setup for running the app in a 
Minikube cluster

<img src="./voting-app.PNG" style="width:100%">

### Prerequisites:

* Docker
* Docker Compose
* Minikube
* jenkins (as a docker container)

### Architecture/Containers :

* vote service - Flask based web app (vote)
* Result Service - Node.js app (view results)
* Worker Service - .NET service (processes votes)
* db service - PostgreSQL (store votes)

### CI/CD Pipeline :

* Pushing vote ,result & worker to docker hub using <a href="./jenkinsfile">JenkinsFile</a> 
* utilized a <a href="./gs.groovy">Function</a> template to build and push the images 
  - hamdiz0/va-vote:1.0
  - hamdiz0/va-result:1.0
  - hamdiz0/va-worker:1.0
  - redis:alpine (default)
  - postgres:15-alpine (default)
* configured a webhook between jenkins and github to trigger the builds automaticly 

### Running the app :

* using the Docker files :
  - docker compose up --build
* using the docker images from DockerHub :
  - docker compose up -f ./docker-compose-images.yml up
---
# Kubernetes Cluser :

* added kubernetes configuration files to deploy the app as a cluster on Minikube

<img src="./cluster.PNG" style="width:100%">

### YAML files templates :

* utilized deployments for each service 
* configured the vote and result services with a NodePort service-type for easy access from outside the cluster
  - <a href="./k8s-specifications/vote-deployment_svc.yml">vote.YAML</a>
  - <a href="./k8s-specifications/result-deployment_svc.yml">result.YAML</a>
* configured the db(postgres) and redis services with a ClusterIP service-type for an efficient comminication inside the cluster
  - <a href="./k8s-specifications/redis-deployment_svc.yml">redis.YAML</a>
  - <a href="./k8s-specifications/postgres-deployment_svc.yml">postgres.YAML</a>
* no need to configure a service for the worker as it only forwards requests
  - <a href="./k8s-specifications/worker-deployment.yml">worker.YAML</a>

### start the app :

  - minikube start or minikube start --driver docker
  - alias kubectl="minikube kubectl --" (make youre life easier with this alias)
  - kubectl apply -f "file.YAML" for each file in the k8s-specifications
  - alternativly you can run the script : <a href="./k8s-specifications/cluster-run.sh">cluster-run.sh</a>
  - add execute permissions :
    * chmod +x cluster-run.sh


## Checkout my <a href="https://github.com/hamdiz0/LearningDevOps">LearningDevops</a> repo for more details about these tools and devops in general