
// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v5.0.2/contracts/token/ERC20/ERC20.sol";

/**
 * Solidity ERC20合约
 * 
 */
contract erc20Test is ERC20{
    constructor (string memory _name , string memory _symbol ,uint _totalSupply) ERC20(_name, _symbol){
        _mint(msg.sender, _totalSupply);
    }
}