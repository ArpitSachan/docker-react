FROM node:alpine

WORKDIR '/app'

COPY package.json .
RUN npm install
COPY . .

RUN npm run build

# /app/build --> will have all the dependencies

FROM nginx
# exposing nginx port to elasticbeanstalk
EXPOSE 80
# Copying everything from last run.
COPY --from=0 /app/build /usr/share/nginx/html
