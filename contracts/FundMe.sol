// SPDX-License-Identifier: MIT

// Get funds from users 
// Withdraw funds
// Set a minimum funding value in USD

pragma solidity ^0.8.24;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";
import {PriceConverter} from "./PriceConverter.sol";

error NotOwner();

contract FundMe {

    using PriceConverter for uint256;

    uint256 public constant MINIMUN_USD = 5e18;

    address[] public funders;
    mapping(address funder => uint256 amountFunded) public addressToAmountFunded; 

    address public immutable i_owner;

    constructor() {
       i_owner = msg.sender;
    }

    function fund() public payable {

        // Allow users to send money
        // Have a minimun money sent $5 USD
        require(msg.value.getConversionRate() >= MINIMUN_USD, "Didn't send enough ETH" ); // 1e18 = 1ETH = 1000000000000000000 = 1 * 10 ** 18
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] = addressToAmountFunded[msg.sender] + msg.value;
        //What is a revert?
        // Undo any action that have been done, and send the remaining gas back
    }

    function withdraw() public onlyOwner {
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

    function getVersion() public view returns (uint256) {
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        return priceFeed.version();
    }

    // Executes the modifier first where we addit 
    modifier onlyOwner() {
        //require(msg.sender == i_owner, "Sender is not owner");
        // _: means after the modifier execute the rest of the code
        // Using custom errors
        if(msg.sender != i_owner) {revert NotOwner();}
        _;
    }

    // What happens if someone sends this contract ETH without calling the fund function

    receive() external payable {
        fund();
    }

    fallback() external payable {
        fund();
    }

}