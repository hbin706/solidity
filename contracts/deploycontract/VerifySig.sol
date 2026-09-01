// SPDX-License-Identifier: MIT
pragma solidity ^0.8.3;
//0x9D7f74d0C41E726EC95884E0e97Fa6129e3b5E99
//0xC7C0f49E161e983841119662700b2da366cff9D2
//0x5B38Da6a701c568545dCfcB03FcB875f56beddC4
//ethereum.request({method: "personal_sign", params: [account, hash]})  F12 命令
contract VerifySig{
    function verify(address _signer, string memory _message, bytes memory _sig)
    external pure returns (bool)
    {
        bytes32 messageHash = getMessageHash(_message);
        bytes32 ethSignedMessageHash = getEthSignedMessageHash(messageHash);
        return recover(ethSignedMessageHash,_sig) == _signer;
    }

    function getMessageHash(string memory _message) public pure returns(bytes32) {
        return keccak256(abi.encodePacked(_message));
    }

    function getEthSignedMessageHash(bytes32 _messageHash) public pure returns (bytes32){
        return keccak256(abi.encodePacked(
            "\x19Ethereum Signed Message:\n32",
            _messageHash
        ));
    }

    function recover(bytes32 _ethSignedMessageHash, bytes memory _sig)
        public pure returns(address)
    {
        (bytes32 r, bytes32 s, uint8 v) = _split(_sig);
        return ecrecover(_ethSignedMessageHash, v, r, s);
    }

    function _split(bytes memory _sig) internal pure 
        returns (bytes32 r, bytes32 s, uint8 v)
        {
            require(_sig.length == 65, "invalid sinnature length");

            assembly {
                r := mload(add(_sig,32))
                s := mload(add(_sig,64))
                v := byte(0 , mload(add(_sig,96)))
            }
        }
}