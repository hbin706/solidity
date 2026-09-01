// SPDX-License-Identifier: MIT
pragma solidity ^0.8.3;

contract pay {
    constructor() payable {}

    receive() external payable { }

    function sendTransform(address payable _to)external payable {
        _to.transfer(123);
    }

    function send(address payable _to)external payable {
        bool sent = _to.send(123);
        require(sent,"send failed");
    }


    function sendCall(address payable _to)external payable {
         (bool success,) = _to.call{value :123}("");
         require(success,"call failed");
    }
}