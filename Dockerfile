FROM node:10-stretch

RUN apt-get update \
    && apt-get install -y python3 python3-dev python3-pip \
    && apt-get clean && rm -rf /var/cache/apt/* && rm -rf /var/lib/apt/lists/* && rm -rf /tmp/*

# jupyter and nbconvert are required to read jupyter notebooks by the python extension
RUN pip3 install pylint jupyter nbconvert

RUN mkdir -p /home/project

ARG version=next

WORKDIR /home/theia
ADD $version.package.json ./package.json
ADD ms-python-release.vsix plugins/

# using "NODE_OPTIONS=..." to avoid out-of-memory problem in CI
RUN yarn --cache-folder ./ycache && rm -rf ./ycache && \
    NODE_OPTIONS="--max_old_space_size=4096" yarn theia build
EXPOSE 3000
ENV SHELL /bin/bash
CMD [ "yarn", "theia", "start", "--plugins=local-dir:./plugins", "--hostname=0.0.0.0", "/home/project" ]
