#!/bin/bash

build() {
    buildType=$1
    nodeVersionsWithABI=("12;72" "14;83" "16;93")

    for nodeVersionWithABIString in ${nodeVersionsWithABI[@]}; do
        IFS=";" read -r -a nodeVersionWithABI <<< "${nodeVersionWithABIString}"

        nodeVersion=${nodeVersionWithABI[0]}
        abiVersion=${nodeVersionWithABI[1]}

        if [[ "$(docker images -q dashpay/neon-build:node${nodeVersion}-${buildType} 2> /dev/null)" == "" ]]; then
            docker buildx build --load -f Dockerfile.node${nodeVersion}.${buildType} . -t dashpay/neon-build:node${nodeVersion}-${buildType}
        fi

        docker run -v $(pwd):/app dashpay/neon-build:node${nodeVersion}-${buildType} neon build --release

        if [[ "$(uname -m)" == "x86_64" ]]; then
            mv ./native/index.node ./prebuilds/linux-x64/node.abi${abiVersion}.${buildType}.node
        elif [[ "$(uname -m)" == "aarch64" ]]; then
            mv ./native/index.node ./prebuilds/linux-aarch64/node.abi${abiVersion}.${buildType}.node
        else
            echo "Unrecognized architecture! Build artifact was not copied to 'prebuilds' directory."
        fi

    done
}

main() {
    build "glibc"
    build "musl"
}

if [ "${1}" != "--source-only" ]; then
    main "${@}"
fi
