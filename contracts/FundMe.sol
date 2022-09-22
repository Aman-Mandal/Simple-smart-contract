// SPDX-License-Identifier: MIT

pragma solidity ^0.8.8;

contract FundMe{

    function fund() public payable{
        // Want to able to set a minimum fund in the USD
        // 1. How do we send ETH to the contract?
        require(msg.value > 1e18, "Didn't send enough !!"); // 1e18 == 1 * 10 ** 18 === 10000000000000000
    }

    // function withdraw(){

    // }
}