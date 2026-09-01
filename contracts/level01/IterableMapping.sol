// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract IterableMapping {
    // 用于存储键值对的映射
    mapping(address => uint) private data;
    // 用于存储所有键的数组
    address[] private keys;

    // 用于存储键是否存在
    mapping(address => bool) private keyExists;

    // 添加一个键值对
    function add(address _key, uint _value) public {
        if (!keyExists[_key]) {
            keys.push(_key);
            keyExists[_key] = true;
        }
        data[_key] = _value;
    }

    // 删除一个键值对
    function remove(address _key) public {
        if (keyExists[_key]) {
            delete data[_key];
            keyExists[_key] = false;

            // 从 keys 数组中删除对应的键
            for (uint i = 0; i < keys.length; i++) {
                if (keys[i] == _key) {
                    // 将最后一个元素移动到被删除元素的位置
                    keys[i] = keys[keys.length - 1];
                    keys.pop();
                    break;
                }
            }
        }
    }

    // 查询一个键的值
    function get(address _key) public view returns (uint) {
        return data[_key];
    }

    // 遍历所有键
    function getAllKeys() public view returns (address[] memory) {
        return keys;
    }

    // 遍历所有键及其对应的值
    function getAll() public view returns (address[] memory, uint[] memory) {
        uint[] memory values = new uint[](keys.length);
        for (uint i = 0; i < keys.length; i++) {
            values[i] = data[keys[i]];
        }
        return (keys, values);
    }
}
