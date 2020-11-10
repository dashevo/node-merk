#!/bin/bash

if [[ "$OSTYPE" != "darwin"* ]]; then
  echo "This script can be executed from MacOSX only."
  echo ""
  exit 1
fi

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

source /Users/$USER/.cargo/env

rustup install nightly
rustup default nightly

npm i -g neon-cli

neon build --release

NODE_ABI=$(node -e "console.log(process.config.variables.node_module_version)")

mv ./native/index.node ./prebuilds/darwin-x64/node.abi${NODE_ABI}.node
