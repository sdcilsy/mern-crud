FROM node:lts-gallium

ENV NODE_ENV=development

WORKDIR /app

COPY . /app

RUN npm install

CMD [ "npm", "start" ]