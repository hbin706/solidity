
pragma solidity ^0.8.0;
contract SelectorExample {
    function getSelector(string memory functionSignature) public pure returns (bytes4) {
        return bytes4(keccak256(bytes(functionSignature)));
    }
    function getTransferSelector() public pure returns (bytes4) {
        return bytes4(keccak256("transfer(address,uint256)"));
    }

        // 使用 staticcall 调用其他合约的只读函数     
  function staticCallFunction(address target, string memory functionSignature, bytes memory data) public view returns (bool, bytes memory) {         
      bytes4 selector = bytes4(keccak256(bytes(functionSignature)));         
      (bool success, bytes memory result) = target.staticcall(abi.encodeWithSelector(selector, data));         
      return (success, result);     
  }
}