# Helm ETH Node

Ethereum node on Kubernetes using Geth as execution layer client and Prysm as consensus layer client.

## Setup Examples

### Main Net
TODO

### Goerly Test Net
For geth add `--goerli` to use the goerli test net.
See [here](https://geth.ethereum.org/docs/interface/command-line-options) for all command line options.

For prysm you might need to adjust the execution endpoint depending on your Kubernetes namespace.
Also add `--prater` to use the test net.
Read the terms of use and accept `--accept-terms-of-use`
See [here](https://docs.prylabs.network/docs/prysm-usage/parameters) for all command line options.

For faster sync you might want to use [checkpoint sync](https://docs.prylabs.network/docs/prysm-usage/checkpoint-sync).

