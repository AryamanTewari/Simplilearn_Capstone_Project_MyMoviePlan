FROM node:current-alpine3.11 as build-stage

# RUN mkdir -p /app

WORKDIR /usr/src/app

COPY package.json package-lock.json ./

RUN npm install

COPY . .

RUN npm run build --prod

# CMD ["npm", "start"]

FROM nginx:latest-alpine as prod-stage

COPY --from=build-stage /usr/src/app/dist/my-movie-plan /user/share/nginx/html

COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 4040

