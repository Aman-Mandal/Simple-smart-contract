// SPDX-License-Identifier: MIT;

pragma solidity ^0.8.7;

import "./NewPriceConverter.sol";

contract NewFundMe{

    using NewPriceConverter for uint256;

    uint256 public minimumUSD = 10 * 1e18;
    address[] public funders;
    mapping(address => uint256) public addressToAmountFunded;

    function fund() public payable {
        require(msg.value.getConversionRate() >= minimumUSD, "Didn't send enough!");
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] = msg.value;
    }

    function withdraw() public payable {

        // emptying map
        for (uint256 funderIndex = 0; funderIndex < funders.length; funderIndex++ ){
            address funder = funders[funderIndex];
            addressToAmountFunded[funder]=0;
        }

        // emptying arr
        funders = new address[](0);

        // withdrawing
        (bool callSucess, ) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSucess, "Withdraw unsuccessfull");
    }
}