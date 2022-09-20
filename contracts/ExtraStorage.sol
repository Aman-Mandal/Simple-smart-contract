// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

import "./SimpleStorage.sol";

// Inheriting the SimpleStorage contract
contract ExtraStorage is SimpleStorage{

    // Overriding the store function of SimpleStorage

    // Note : to override function use 'override' in the current function and add 'virtual' keyword to the ovveriding function
    function store(uint256 _favNumber) public override {
        favNumber = _favNumber + 10;
    }
}