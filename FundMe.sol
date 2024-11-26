// SPDX-License-Identifier: MIT

// Get funds from users 
// Withdraw funds
// Set a minimum funding value in USD

pragma solidity ^0.8.24;

import {PriceConverter} from "./PriceConverter.sol";

contract FundMe {

    using PriceConverter for uint256;

    uint256 public minimumUsd = 5e18;

    address[] public funders;
    mapping(address funder => uint256 amountFunded) public addressToAmountFunded; 

    function fund() public payable {

        // Allow users to send money
        // Have a minimun money sent $5 USD
        require(msg.value.getConversionRate() >= minimumUsd, "Didn't send enough ETH" ); // 1e18 = 1ETH = 1000000000000000000 = 1 * 10 ** 18
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] = addressToAmountFunded[msg.sender] + msg.value;
        //What is a revert?
        // Undo any action that have been done, and send the remaining gas back
    }

    // function withdraw() public {

    // }


}