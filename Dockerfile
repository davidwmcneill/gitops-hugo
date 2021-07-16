FROM klakegg/hugo:0.78.2-alpine
RUN apk add -U git
COPY . /src
# RUN make init
RUN make build

FROM nginx:1.19.4-alpine
COPY nginx/nginx-prod.conf /etc/nginx/nginx.conf
COPY nginx/nginx-app.conf /etc/nginx/conf.d/nginx-app.conf
RUN mv /usr/share/nginx/html/index.html /usr/share/nginx/html/old-index.html
COPY --from=0 /src/public /usr/share/nginx/html
EXPOSE 80