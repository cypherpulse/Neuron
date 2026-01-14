#!/bin/bash

# Load environment variables
source .env

# Deploy NEUR to Base Sepolia testnet
forge script script/DeployNeuron.s.sol \
  --rpc-url $BASE_SEPOLIA_RPC_URL \
  --account defaultKey \
  --broadcast \
  --verify \
  --etherscan-api-key $BASESCAN_API_KEY