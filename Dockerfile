FROM "registry.invoice2go.io/i2g/itg-node:8.9.0"

COPY --chown=node:node . .
RUN gosu node:node npm install --production=false
