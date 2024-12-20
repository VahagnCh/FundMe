// SPDX-License-Identifier: MIT

pragma solidity ^0.8.24;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

library PriceConverter{

    function getPrice() internal view returns (uint256) {
        // Adress 0x694AA1769357215DE4FAC081bf1f309aDC325306
        // ABI 
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
       (, int256 price, , , ) = priceFeed.latestRoundData();
       // Price of ETH in terms of USD
       //2000.00000000
       return uint256 (price * 1e10);
    }

    function getConversionRate(uint256 ethAmout) internal view returns(uint256){
        // 1 ETH price in usd?
        // 2000_000000000000000000
        uint256 ethPrice = getPrice();
        // (2000_000000000000000000 * 1_000000000000000000) / 1e18;
        // $2000 = 1ETH
        uint256 ethAmoutInUsd = (ethPrice * ethAmout) / 1e18;
        return ethAmoutInUsd;
    }

    function getVersion() internal view returns (uint256) {
        return AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306).version();
    }
}