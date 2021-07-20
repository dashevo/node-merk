#!/bin/bash

build() {
    buildType=$1
    nodeVersionsWithABI=("12;72" "14;83")

    for nodeVersionWithABIString in ${nodeVersionsWithABI[@]}; do
        IFS=";" read -r -a nodeVersionWithABI <<< "${nodeVersionWithABIString}"

        nodeVersion=${nodeVersionWithABI[0]}
        abiVersion=${nodeVersionWithABI[1]}

        if [[ "$(docker images -q dashpay/neon-build:node${nodeVersion}-${buildType} 2> /dev/null)" == "" ]]; then
            docker build -f Dockerfile.node${nodeVersion}.${buildType} . -t dashpay/neon-build:node${nodeVersion}-${buildType}
        fi

        docker run -v $(pwd):/app dashpay/neon-build:node${nodeVersion}-${buildType} neon build --release

        mv ./native/index.node ./prebuilds/linux-x64/node.abi${abiVersion}.${buildType}.node
    done
}

main() {
    build "glibc"
    build "musl"
}

if [ "${1}" != "--source-only" ]; then
    main "${@}"
fi
