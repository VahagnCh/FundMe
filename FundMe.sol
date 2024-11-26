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

    address public owner;

    constructor() {
        owner = msg.sender;
    }

    function fund() public payable {

        // Allow users to send money
        // Have a minimun money sent $5 USD
        require(msg.value.getConversionRate() >= minimumUsd, "Didn't send enough ETH" ); // 1e18 = 1ETH = 1000000000000000000 = 1 * 10 ** 18
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] = addressToAmountFunded[msg.sender] + msg.value;
        //What is a revert?
        // Undo any action that have been done, and send the remaining gas back
    }

    function withdraw() public {
        require(msg.sender == owner, "Must be the owner");
        for(uint256 funderIndex = 0; funderIndex < funders.length; funderIndex ++) {
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }
        // Reset Array 
        funders = new address[](0);
        // Withdraw the funds
        // Transfer msg.sender = adress / payable(msg.adress) = payable adress
        // payable(msg.sender).transfer(address(this).balance);
        // Send
        // bool sendSuccess = payable(msg.sender).send(address(this).balance);
        // require(sendSuccess, "Send Failed");
        // Call
        (bool callSuccess,) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSuccess, "Call Failed");

    }


}