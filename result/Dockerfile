FROM node:18-slim

WORKDIR /result

COPY package*.json ./

RUN npm ci && npm cache clean --force

COPY . .

ENV PORT 80

EXPOSE 80

ENTRYPOINT [ "node" , "server.js"]

