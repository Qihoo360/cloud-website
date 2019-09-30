## build website
FROM q8sio/hugo:0.56.3 as website

COPY . /src

RUN ["hugo"]

## build wayne-docs
FROM 360cloud/gitbook:3.2.3 as wayne-docs

COPY ./docs/wayne /srv/gitbook

RUN gitbook install && \
    gitbook build .

## build release image
FROM nginx:1.15.2

COPY --from=website /src/public/ /usr/share/nginx/html/

COPY --from=wayne-docs /srv/gitbook/_book/ /usr/share/nginx/html/wayne
