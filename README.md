# Vote-App

<a href="https://github.com/dockersamples/example-voting-app">based on example-voting-app</a>

## A containerized voting app split into 5 containers :

<img src="./voting-app.PNG" style="width:100%">

  - vote (Flask)
  - result (NodeJs)
  - worker (.Net)
  - redis 
  - postgres

## Pushing vote ,result & worker to docker hub using Jenkins :

* utilized a function template to build and push the images 
* take a look at the <a href="./gs.groovy">function</a> along with the <a href="./jenkinsfile">Jenkins file</a>
* check out the images :
  - hamdiz0/va-vote:1.0
  - hamdiz0/va-result:1.0
  - hamdiz0/va-worker:1.0

## Running the app :

  - docker compose up --build
  - docker compose up -f ./docker-compose-images.yml up

  
