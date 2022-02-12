FROM node:16.14-alpine3.14

MAINTAINER Riaz Uddin Masum <masum@activelava.net>


RUN \
    echo "==> Install app..."                && \
    npm install -g --production json-server  && \
    \
    \
    echo "==> Remove unused temp..."         && \
    rm -rf /root/.npm                  \
           /usr/lib/node_modules/npm


# configure
EXPOSE 3000
VOLUME [ "/data" ]
WORKDIR /data

# Define default command.
ENTRYPOINT ["json-server", "--host", "0.0.0.0"]
CMD ["--help"]
