#!/bin/bash

if [[ "$(docker images -q dashpay/neon-build:musl 2> /dev/null)" == "" ]]; then
  docker build -f Dockerfile.musl . -t dashpay/neon-build:musl
fi

docker run -v $(pwd):/app dashpay/neon-build:musl neon build

mv ./native/index.node ./prebuilds/node.abi72.musl.node
