#!/bin/bash

if [[ "$(docker images -q dashpay/neon-build:gnu 2> /dev/null)" == "" ]]; then
  docker build -f Dockerfile.gnu . -t dashpay/neon-build:gnu
fi

docker run -v $(pwd):/app dashpay/neon-build:gnu neon build

mv ./native/index.node ./prebuilds/linux-x64/node.abi72.glibc.node
