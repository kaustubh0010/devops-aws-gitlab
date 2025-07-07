#Stage 1
FROM node:18.19-alpine AS base

WORKDIR /app

COPY ./package*.json /app/

RUN npm install

#Stage 2
FROM base AS build

COPY . . 

ARG NEXT_PUBLIC_API_URL
ENV NEXT_PUBLIC_API_URL=${NEXT_PUBLIC_API_URL}

RUN npm run build

#Stage 3
FROM nginx:1.27-alpine

WORKDIR /app

RUN rm /etc/nginx/conf.d/default.conf

COPY --from=build /app/nginx.conf /etc/nginx/conf.d/

COPY --from=build /app/out/ /usr/share/nginx/html/

CMD ["nginx", "-g", "daemon off;"]




