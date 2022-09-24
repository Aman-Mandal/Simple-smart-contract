// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

import "./PriceConverter.sol";

contract FundMe{
    // attaching our Library to uint256
    using PriceConverter for uint256;

    uint256 public minimumUSD = 10 * 1e18;

    address[] public funders;
    mapping(address => uint256) public addressToAmountFunded;

    function fund() public payable{
        // Want to able to set a minimum fund in the USD
        // 1. How do we send ETH to the contract?

        // 'msg' is a global variable; msg.value gives is the amount send with the contract
        // 'require' is like response-error 

        // before : require(getConversionRate(msg.value))
        // after using library we can use the library functions as the methods like js
        require(msg.value.getConversionRate() >= minimumUSD, "Didn't send enough !!"); // 1e18 == 1 * 10 ** 18 === 10000000000000000
        funders.push(msg.sender);    // msg.sender will give the address of the user that calls the fund function

        // this will create a map of 'key' of addressess and value of 'amount'
        addressToAmountFunded[msg.sender] = msg.value;
    }

    
    
}