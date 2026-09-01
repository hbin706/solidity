
pragma solidity ^0.8.0;
contract FallbackExample {
    event Log(string func, address sender, uint amount, bytes data);
    
    fallback() external payable {
        emit Log("fallback",msg.sender, msg.value, msg.data);
    }

     receive() external payable {
        emit Log("receive", msg.sender, msg.value, "" );
    }

    event Deposit(address sender, uint amount);
    function deposit() external payable {
        require(msg.value > 0, "Must send some Ether");
        emit Deposit(msg.sender, msg.value);
    }
    function getBalance() external view returns (uint) {
        return address(this).balance;
    }

    
}