
pragma solidity ^0.8.0;
contract PayableExample {
    event Deposit(address sender, uint amount);
    function deposit() external payable {
        
        emit Deposit(msg.sender, msg.value);
    }
    function getBalance() external view returns (uint) {
        return address(this).balance;
    }
}