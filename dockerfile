FROM node:10

RUN mkdir /myapp

WORKDIR /myapp

COPY ./package.json /myapp/package.json
COPY ./package-lock.json /myapp/package-lock.json

RUN npm install
RUN npm install -g nodemon

COPY . /myapp

EXPOSE 8080

CMD [ "nodemon", "app.js" ]