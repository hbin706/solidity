 // SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;
 

contract test {
    
    constructor() payable {}

    struct Transaction {
        address payable to;//交易发送的目标地址
        uint value;//交易发送的主币数量
    }

    Transaction[] public transactions;

    function queryEth() public view returns (uint){
        return address(this).balance;
    }

    function submitTransaction(address _to,uint _value) public {

        transactions.push(
            Transaction({
                to: payable(_to),
                value: _value
            })
        );
    }

    function transform() public {
        Transaction storage transaction = transactions[0];
        (bool success, ) = transaction.to.call{value: transaction.value}("");
        require(success, "tx failed");
    }
}

contract EthReceiver{
    receive() external payable { }
      function queryEth() public view returns (uint){
        return address(this).balance;
    }
}

