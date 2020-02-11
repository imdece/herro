ARG node_version=8.9
ARG kcl_version=1.7

FROM "registry.invoice2go.io/i2g/app:node${node_version}-kcl${kcl_version}"

COPY --chown=node:node . .
RUN gosu node:node npm install --production=false
