//Get Funds From Users
//Withdraw funds
// Set Minimum Deposit Amount

//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {PriceConverter} from "./PriceConvertor.sol";

contract Fundme{

    using PriceConverter for uint256;
    uint256 public minimumUsd = 5e18;

    address[] public funders;
    mapping(address funder => uint256 amountFunded) public addressToAmountFunded;

    function fund() public payable {
        //Allows users to send money
        //Set minimum send amount
        require(msg.value.getConversionRate() >= minimumUsd , "Didnt deploy enough eth");
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] = addressToAmountFunded[msg.sender] + msg.value;
    }

    function withdraw() public{}

}
