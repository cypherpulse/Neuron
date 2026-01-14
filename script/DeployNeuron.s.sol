// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Script.sol";
import "../src/Neuron.sol";

contract DeployNeuron is Script {
    function run() external {
        vm.startBroadcast();
        new Neuron();
        vm.stopBroadcast();
    }
}