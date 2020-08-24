## Vue + Nginx Deployment
Small recipe to build a Vue.js 2 app and deploy it. Problem: you want to build and deploy your staging and production app with different environment files. Both should be build together in one Docker image. 


Local Proof of concept - test run the container before building the image
```
cd hello-world
npm run build:staging
npm run build:production
cd ../
docker-compose up
```

Staging
```
docker build -t vue-docker-env .
docker run -p 8080:8080 -e NGINX_PORT=8080 -e STAGE_FOLDER=staging vue-docker-env 
```

Run Staging
```
docker run -p 8080:8080 -e NGINX_PORT=8080 -e STAGE_FOLDER=staging vue-docker-env 
```

Run Production
```
docker run -p 8080:8080 -e NGINX_PORT=8080 -e STAGE_FOLDER=production vue-docker-env 
```
