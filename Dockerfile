FROM node AS prod
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

FROM nginx:alpine AS prod1
WORKDIR /usr/share/nginx/html
COPY --from=prod /app/dist .
EXPOSE 80
ENTRYPOINT ["nginx", "-g", "daemon off;"]