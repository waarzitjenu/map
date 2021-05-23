FROM node:14 AS builder

RUN mkdir -p /home/node/.npm-global \
             /app/map \
             /app/map/dist && \
    chown -R node:node /app /home/node
USER node
             
ENV NPM_CONFIG_PREFIX=/home/node/.npm-global
ENV PATH=$NPM_CONFIG_PREFIX/bin:$PATH
RUN npm -g config set user "$USER" && \
    npm i -g yarn && \
    printf "Node version %s, npm version %s, yarn version %s\n\n" "$(node -v)" "$(npm -v)" "$(yarn -v)"

WORKDIR /app/map
COPY ./ ./
RUN yarn install
RUN yarn build

FROM nginx:1.20-alpine
COPY --from=builder /app/map/dist /usr/share/nginx/html
COPY ./docker-entrypoint.sh /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]
