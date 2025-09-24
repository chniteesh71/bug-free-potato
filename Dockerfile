FROM node:22-alpine3.21

WORKDIR /app

COPY src/package*.json ./

RUN npm ci --only=production

COPY src/* .

EXPOSE 3000

CMD ["node", "index.js"]
