// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract Event {
    // Event declaration
    // Up to 3 parameters can be indexed.
    // Indexed parameters helps you filter the logs by the indexed parameter
    event Log(address indexed sender, string message, string t1, string t2);
    event AnotherLog();

    function test(string memory str1,string memory str2) public {
        emit Log(msg.sender, "Hello World!",str1,"t2");
        emit Log(msg.sender, "Hello EVM!","t1",str2);
        emit AnotherLog();
    }
}