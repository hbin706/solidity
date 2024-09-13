
pragma solidity ^0.8.0;
contract EncodeExample {
    function encodeData(uint a, string memory b) public pure returns (bytes memory) {
        return abi.encode(a, b);
    }
}