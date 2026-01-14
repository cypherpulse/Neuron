// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/Neuron.sol";

contract NeuronTest is Test {
    Neuron neuron;
    address owner = address(1);
    address user = address(2);

    function setUp() public {
        vm.prank(owner);
        neuron = new Neuron();
    }

    function testMintOnlyOwner() public {
        vm.prank(owner);
        neuron.mint(user, 1000);
        assertEq(neuron.balanceOf(user), 1000);
    }

    function testMintNotOwner() public {
        vm.prank(user);
        vm.expectRevert(abi.encodeWithSelector(Ownable.OwnableUnauthorizedAccount.selector, user));
        neuron.mint(user, 1000);
    }

    function testTransfer() public {
        vm.prank(owner);
        neuron.mint(owner, 1000);
        vm.prank(owner);
        neuron.transfer(user, 500);
        assertEq(neuron.balanceOf(owner), 500);
        assertEq(neuron.balanceOf(user), 500);
    }

    function testBurn() public {
        vm.prank(owner);
        neuron.mint(user, 1000);
        vm.prank(user);
        neuron.burn(500);
        assertEq(neuron.balanceOf(user), 500);
    }

    function testBurnFrom() public {
        vm.prank(owner);
        neuron.mint(owner, 1000);
        vm.prank(owner);
        neuron.approve(user, 500);
        vm.prank(user);
        neuron.burnFrom(owner, 500);
        assertEq(neuron.balanceOf(owner), 500);
    }

    function testOwnable() public {
        assertEq(neuron.owner(), owner);
        vm.prank(owner);
        neuron.transferOwnership(user);
        assertEq(neuron.owner(), user);
    }

    function testOwnableRevert() public {
        vm.prank(user);
        vm.expectRevert(abi.encodeWithSelector(Ownable.OwnableUnauthorizedAccount.selector, user));
        neuron.transferOwnership(user);
    }
}