#!/bin/env bash

ganache_port=8545
network_id=5777
gas_limit=7000000000000
mnemonic='ivory sibling about kiwi grant sunset beauty solar cup fame south girl'

if [ -d .chain ]; then 
    mkdir -p .chain
fi

ganache-cli \
    --port ${ganache_port} \
    --deterministic \
    --networkId ${network_id} 
    --gasLimit ${gas_limit} \
    --gasPrice 1 \
    --acctKeys ./.chain/ganache-accounts.json \
    --mnemonic ${mnemonic}