// SPDX-License-Identifier: MIT

// Get funds from users 
// Withdraw funds
// Set a minimum funding value in USD

pragma solidity ^0.8.24;

contract FundMe {
    function fund() public payable {
        // Allow users to send money
        // Have a minimun money sent
        require(msg.value > 1e18, "Didn't send enough ETH" ); // 1e18 = 1ETH = 1000000000000000000 = 1 * 10 ** 18
    }

    // function withdraw() public {

    // }

}