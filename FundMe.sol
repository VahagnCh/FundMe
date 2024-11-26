// SPDX-License-Identifier: MIT

// Get funds from users 
// Withdraw funds
// Set a minimum funding value in USD

pragma solidity ^0.8.24;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

contract FundMe {

    uint256 public minimumUsd = 5;

    function fund() public payable {
        // Allow users to send money
        // Have a minimun money sent $5 USD
        require(msg.value >= minimumUsd, "Didn't send enough ETH" ); // 1e18 = 1ETH = 1000000000000000000 = 1 * 10 ** 18
        //What is a revert?
        // Undo any action that have been done, and send the remaining gas back
    }

    // function withdraw() public {

    // }

    function getPrice() public view returns (uint256) {
        // Adress 0x694AA1769357215DE4FAC081bf1f309aDC325306
        // ABI 
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
       (, int256 price, , , ) = priceFeed.latestRoundData();
       // Price of ETH in terms of USD
       //2000.00000000
       return uint256 (price * 1e10);
    }

    function getConversionRate() public {


    }

    function getVersion() public view returns (uint256) {
        return AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306).version();
    }

}