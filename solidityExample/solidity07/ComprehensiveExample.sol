
pragma solidity ^0.8.0;
contract ComprehensiveExample {
    event FallbackCalled(address sender, uint amount, bytes data);
    event Received(address sender, uint amount);
    event DataDecoded(uint a, string b);
    // Fallback 函数
    fallback() external payable {
        emit FallbackCalled(msg.sender, msg.value, msg.data);
    }
    // Receive 函数
    receive() external payable {
        emit Received(msg.sender, msg.value);
    }
    // Payable 函数
    function deposit() external payable {
        require(msg.value > 0, "Must send some Ether");
    }
    // 获取合约余额
    function getBalance() external view returns (uint) {
        return address(this).balance;
    }
    // 获取函数选择器
    function getSelector(string memory functionSignature) public pure returns (bytes4) {
        return bytes4(keccak256(bytes(functionSignature)));
    }
    // 编码数据
    function encodeData(uint a, string memory b) public pure returns (bytes memory) {
        return abi.encode(a, b);
    }
    // 解码数据
    function decodeData(bytes memory data) public returns (uint, string memory) {
        (uint a, string memory b) = abi.decode(data, (uint, string));
        emit DataDecoded(a, b);
        return (a, b);
    }
    // 动态调用函数
    function callFunction(address target, string memory functionSignature, bytes memory data) public returns (bool, bytes memory) {
        bytes4 selector = bytes4(keccak256(bytes(functionSignature)));
        (bool success, bytes memory result) = target.call(abi.encodeWithSelector(selector, data));
        return (success, result);
    }
}