#!/bin/sh
ROOT_DIR=/usr/share/nginx/html
envsubst < "$ROOT_DIR/config.template.json" > "$ROOT_DIR/config.json"

nginx -g "daemon off;"
