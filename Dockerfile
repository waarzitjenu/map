# Working Node.js 14 base image
FROM node:14 AS nodebase
RUN mkdir -p /home/node/.npm /app/ && \
    chown -R node:node /home/node/ /app/
USER node
ENV NPM_CONFIG_PREFIX=/home/node/.npm
ENV PATH=$NPM_CONFIG_PREFIX/bin:$PATH
RUN npm -g config set user "$USER" && \
    npm i -g yarn && \
    printf "Node version %s, npm version %s, yarn version %s\n\n" "$(node -v)" "$(npm -v)" "$(yarn -v)"

# Builder
FROM nodebase AS builder
WORKDIR /app/
RUN mkdir -p map/ map/dist/
WORKDIR /app/map
COPY ./ ./
RUN yarn install
RUN yarn build

# Nginx
FROM nginx:1.25.2-alpine
COPY --from=builder /app/map/dist /usr/share/nginx/html
COPY ./docker-entrypoint.sh /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]
