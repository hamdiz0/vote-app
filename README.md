# vote-app

<a href="https://github.com/dockersamples/example-voting-app">based on example-voting-app</a>

## A containerized voting app split into 5 containers :

<img src="./voting-app.PNG" style="width:100%">

  - vote (Flask)
  - result (NodeJs)
  - worker (.Net)
  - redis 
  - postgres
## Running the app :
  - docker compose up --build
## Pushing vote ,result & worker to docker hub using jenkins :
  - hamdiz0/va-vote:latest
  - hamdiz0/va-result:latest
  - hamdiz0/va-worker:latest
  
