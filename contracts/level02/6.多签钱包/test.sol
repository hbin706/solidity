

pragma solidity ^0.8.17;

contract test {
    

    function getAddress () public view returns (address[] memory){
        address[] memory addresses = new address[](2);
        addresses[0] = 0xEe0E144FE7dE487C6b137689b3AA312411a0760C;
        addresses[1] = 0xA27A307663cf307E0E33443Eb0fD2aC15BD40900;
        return addresses;
    }
}
