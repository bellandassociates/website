#!/bin/bash

podman run --rm -it -v .:/workdir:Z -p 8080:8080 localhost/bna-site-compile

podname=$(kubectl -n bna-website get pod -l app=bna-website -o name | head -n 1)
kubectl -n bna-website exec $podname -- sh -c "rm -r /usr/share/nginx/html/*"
kubectl cp site/. bna-website/${podname#pod/}:/usr/share/nginx/html
