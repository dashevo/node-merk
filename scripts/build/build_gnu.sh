#!/bin/bash

if [[ "$(docker images -q dashpay/neon-build:gnu 2> /dev/null)" == "" ]]; then
  docker build -f Dockerfile.gnu . -t dashpay/neon-build:gnu
fi

docker run -v $(pwd):/app dashpay/neon-build:gnu neon build

mv ./native/index.node ./prebuilds/node.abi72.glibc.node
