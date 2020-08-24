## Vue + Nginx Docker Deployment
Small recipe to build a Vue.js 2 app and deploy it. Problem: you want to build and deploy your staging and production app with different environment files. Both should be build together in one Docker image. 


Local Proof of concept - test run the container before building the image
STAGE_FOLDER in docker-compose can be set to "staging" or "production"
```
cd hello-world
npm run build:staging
npm run build:production
cd ../
docker-compose up
```


Build Docker image with both stages
```
docker build -t vue-docker-env .
```

Run Staging
```
docker run -p 8080:8080 -e NGINX_PORT=8080 -e STAGE_FOLDER=staging vue-docker-env 
```

Run Production
```
docker run -p 8080:8080 -e NGINX_PORT=8080 -e STAGE_FOLDER=production vue-docker-env 
```
