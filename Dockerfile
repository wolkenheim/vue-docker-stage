# build stage
FROM node:lts-alpine as build-stage

WORKDIR /app
COPY ./hello-world/package*.json ./
RUN npm install
COPY ./hello-world/ .
RUN rm -rf production staging
RUN npm run build:staging
RUN npm run build:production

# production stage
FROM nginx:1.19-alpine as production-stage
COPY --from=build-stage /app/staging /usr/share/nginx/html/staging
COPY --from=build-stage /app/production /usr/share/nginx/html/production

COPY ./nginx-templates /etc/nginx/templates

EXPOSE 8080
CMD ["nginx", "-g", "daemon off;"]