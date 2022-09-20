// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

import "./SimpleStorage.sol";

contract StorageFactory{

    SimpleStorage[] public simpleStorageArray;

    // function to create new contracts with every call
    function createSimpleStorageContract() public {

        // 'new' keyword deploys a new contract
        SimpleStorage simpleStorage = new SimpleStorage();
        simpleStorageArray.push(simpleStorage);
    }

    // For interacting with other contracts we always need 2 things:
    // 1. Address
    // 2. ABI - Application Binary Interface

    function sfStore(uint256 _index, uint256 _number)public{
        simpleStorageArray[_index].store(_number);
    }

    function sfGet(uint256 _index) public view returns(uint256) {
      return simpleStorageArray[_index].retrieve();
    }

}