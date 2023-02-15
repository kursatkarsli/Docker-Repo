

# Node server
FROM node:12-alpine as node-server
WORKDIR /src/app
COPY ["package.json", "package-lock.json ."]
RUN npm install
COPY . .
RUN npm build

FROM nginx:1.19.0 as nginx-server
WORKDIR /usr/share/nginx/html
RUN rm -rf ./*
COPY --from=builder /app/build .
ENTRYPOINT [ "nginx", "-g", "daemon off;" ]

