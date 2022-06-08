FROM node:18-alpine as build

RUN apk add git openssh

RUN git clone --depth=1 https://github.com/bangle-io/bangle-io.git

WORKDIR /bangle-io/

RUN git checkout dev

RUN ["yarn", "install"]
RUN [ "yarn", "build" ]


FROM nginx:alpine

WORKDIR /usr/share/nginx/html
RUN rm -rf ./*
COPY --from=build /bangle-io/build .

EXPOSE 80

ENTRYPOINT ["nginx", "-g", "daemon off;"]
