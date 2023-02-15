

# Node server
FROM node:17-alpine as node-server
WORKDIR /app
COPY package.json .
COPY package-lock.json .
RUN yarn install
COPY . .
RUN yarn build

FROM nginx:1.19.0
WORKDIR /usr/share/nginx/html
RUN rm -rf ./*
COPY --from=builder /app/build .
ENTRYPOINT [ "nginx", "-g", "daemon off;" ]

