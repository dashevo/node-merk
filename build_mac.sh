#!/bin/bash

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

source /home/$USER/.cargo/env

rustup install nightly
rustup default nightly

npm i -g neon-cli

neon build --release

mv ./native/index.node ./build/x86_64-apple-darwin.node
