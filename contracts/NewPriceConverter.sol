// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

library NewPriceConverter{

    function getPrice() internal view returns(uint256){
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e);
        (, int price, , ,) = priceFeed.latestRoundData();
        return uint256(price * 1e10); // 1e10 = 10 ** 10;
    }

    function getConversionRate(uint256 ethAmount) internal view returns(uint256){
        uint256 ethPrice = getPrice();
        uint256 ethAmountInUSD = (ethAmount * ethPrice) / 1e18;
        return ethAmountInUSD;
    }

    function getVersion() internal view returns(uint256){
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e);
        return priceFeed.version();
    }

}