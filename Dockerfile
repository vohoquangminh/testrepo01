FROM node: 18.16.0-alpine3.18

RUN addgroup -g 433 -S leap && \
adduser -u 431 -S -G leap -s /sbin/nologin -h /home/temp -D -H -g "Docker image user" leap

ENV NODE TLS REJECT UNAUTHORIZED=0

# Create app director
WORKDIR /app

EN NODE OPTIONS --max-old-space-size=4096

# Install app dependencies
COPY package.json .

RUN apk update && apk add vim jq busybox-extras

RUN nom install --save-exact

# Bundle app source
COPY ..

RUN pm run build

COPY package. json dist/

CMD ["node", "dist/src/main.is"]
