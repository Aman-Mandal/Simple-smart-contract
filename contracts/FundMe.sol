// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract FundMe{

    uint256 public minimumUSD = 50 * 1e18;

    function fund() public payable{
        // Want to able to set a minimum fund in the USD
        // 1. How do we send ETH to the contract?

        // 'msg' is a global variable; msg.value gives is the amount send with the contract
        // 'require' is like response-error 
        require(getConversionRate(msg.value) >= minimumUSD, "Didn't send enough !!"); // 1e18 == 1 * 10 ** 18 === 10000000000000000
    }

    function getPrice() public view returns(uint256) {
        // for using another contract we need 2 things, ABI & Address
        // Address: 	0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e);
        (, int price, , , ) = priceFeed.latestRoundData(); // ETH price in USD
        return uint256(price * 1e10); // 1 ** 10 = 10000000000

    }

    function getVersion() public view returns(uint256){
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e);
        return priceFeed.version();
    }

    function getConversionRate(uint256 ethAmount) public view returns (uint256) {
        uint256 ethPrice = getPrice(); // 1 Eth in USD
        uint256 ethAmountInUSD = (ethPrice * ethAmount) / 1e18;
        return ethAmountInUSD;
    }

    
}