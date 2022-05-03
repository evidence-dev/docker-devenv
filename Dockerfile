FROM node:18-alpine3.14

ARG WORKSPACE_DIR=/evidence-workspace 

RUN apk add --no-cache bash curl wget nano git && \
    npm install -g degit && \
    mkdir -p ${WORKSPACE_DIR} && \
    mkdir -p /evidence-bin

COPY bootstrap.sh /evidence-bin/bootstrap.sh
WORKDIR ${WORKSPACE_DIR}

ENTRYPOINT [ "bash", "/evidence-bin/bootstrap.sh" ]