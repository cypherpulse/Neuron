// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

/**
 * @title NEUR - Neuron Reward Token
 * @author cypherpulse.base.eth
 * @dev ERC20 token for rewarding AI agents and autonomous systems on Base network.
 * Only the owner can mint tokens. No initial supply. Tokens are burnable.
 */
contract Neuron is ERC20, Ownable {
    /**
     * @dev Constructor that sets the name and symbol, and transfers ownership to msg.sender.
     */
    constructor() ERC20("Neuron", "NEUR") Ownable(msg.sender) {}

    /**
     * @dev Mints new tokens to the specified address.
     * Can only be called by the owner.
     * @param to The address to mint tokens to.
     * @param amount The amount of tokens to mint.
     */
    function mint(address to, uint256 amount) external onlyOwner {
        _mint(to, amount);
    }

    /**
     * @dev Burns tokens from the caller's account.
     * @param amount The amount of tokens to burn.
     */
    function burn(uint256 amount) external {
        _burn(_msgSender(), amount);
    }

    /**
     * @dev Burns tokens from the specified account, if the caller has sufficient allowance.
     * @param account The account from which to burn tokens.
     * @param amount The amount of tokens to burn.
     */
    function burnFrom(address account, uint256 amount) external {
        _spendAllowance(account, _msgSender(), amount);
        _burn(account, amount);
    }

    /**
     * @dev Increases the allowance granted to `spender` by the caller.
     * @param spender The address which will spend the funds.
     * @param addedValue The amount of tokens to increase the allowance by.
     * @return A boolean value indicating whether the operation succeeded.
     */
    function increaseAllowance(address spender, uint256 addedValue) public virtual returns (bool) {
        address owner = _msgSender();
        _approve(owner, spender, allowance(owner, spender) + addedValue);
        return true;
    }

    /**
     * @dev Decreases the allowance granted to `spender` by the caller.
     * @param spender The address which will spend the funds.
     * @param subtractedValue The amount of tokens to decrease the allowance by.
     * @return A boolean value indicating whether the operation succeeded.
     */
    function decreaseAllowance(address spender, uint256 subtractedValue) public virtual returns (bool) {
        address owner = _msgSender();
        uint256 currentAllowance = allowance(owner, spender);
        require(currentAllowance >= subtractedValue, "NEUR: decreased allowance below zero");
        unchecked {
            _approve(owner, spender, currentAllowance - subtractedValue);
        }
        return true;
    }
}