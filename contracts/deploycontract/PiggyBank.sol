// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract PiggyBank {
    address public  owner = msg.sender;

    receive() external payable {

    }

    function withdraw() external {
        require(msg.sender ==  owner, "not owner");
        selfdestruct(payable(msg.sender));
    }
}