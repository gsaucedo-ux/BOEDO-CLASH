FROM node:20-slim
WORKDIR /app

COPY mi-backend/package*.json ./
RUN npm install

COPY mi-backend/ .

EXPOSE 3000
CMD ["node", "index.js"]