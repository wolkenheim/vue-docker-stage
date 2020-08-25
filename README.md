## Vue + Nginx Docker Deployment
Small recipe to build a Vue.js project (or any SPA like React or Angular) as an Single-Page-Application (SPA) and deploy it. 

What problem does it trying to solve? You want to build and deploy your staging and production app with different environment files. Both should be build during your CI pipeline in one Docker image only, not two.

You know that already, however: do not check in secret credentials like database passwords for your production environments in any Git repository. Use regular environment variables instead.

So what is the idea here? 
1. Build your project with npm. Each stage needs to go in its own destination folder
2. Copy those folders to your nginx root
3. Use environment variables which can be used easily within templates since nginx1.9 Read the docs for its Docker image: https://hub.docker.com/_/nginx


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
