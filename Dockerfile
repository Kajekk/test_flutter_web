FROM cirrusci/flutter:stable AS build
RUN mkdir /app/
COPY . /app/
WORKDIR /app/
RUN flutter build web

FROM nginx:alpine
COPY nginx.conf /etc/nginx/nginx.conf
COPY --from=build /app/build/web /usr/share/nginx/html

EXPOSE 9080
CMD ["nginx", "-g", "daemon off;"]
