// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/manager/AccessManaged.sol";

contract MyToken is ERC20, AccessManaged {
    constructor(address initialAuthority)
        ERC20("MyToken", "MTK")
        AccessManaged(initialAuthority)
    {}

    function mint(address to, uint256 amount) public restricted {
        _mint(to, amount);
    }
}