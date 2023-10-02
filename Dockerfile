FROM sitespeedio/node:ubuntu-22.04-nodejs-18.16.0
ARG WORKSPACE_DIR=/evidence-workspace 

RUN apt-get update && apt-get install -y \
    curl wget nano git xdg-utils && \
    npm install -g degit && \
    mkdir -p ${WORKSPACE_DIR} && \
    mkdir -p /evidence-bin && \
    rm -rf /var/lib/apt/lists/*

COPY bootstrap.sh /evidence-bin/bootstrap.sh
WORKDIR ${WORKSPACE_DIR}

ENTRYPOINT [ "bash", "/evidence-bin/bootstrap.sh" ]