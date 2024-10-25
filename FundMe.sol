//Get Funds From Users
//Withdraw funds
// Set Minimum Deposit Amount

//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {PriceConverter} from "./PriceConvertor.sol";

error notOwner();
contract Fundme{

    using PriceConverter for uint256;
    uint256 public constant MINIMUM_USD = 5e18;

    address[] public funders;
    mapping(address funder => uint256 amountFunded) public addressToAmountFunded;
    address public immutable i_owner;

    constructor() {
        i_owner = msg.sender;
    }

    function fund() public payable {
        //Allows users to send money
        //Set minimum send amount
        require(msg.value.getConversionRate() >= MINIMUM_USD , "Didnt deploy enough eth");
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] = addressToAmountFunded[msg.sender] + msg.value;
    }

    function withdraw() public onlyOwner{
        for (uint funderIndex = 0; funderIndex < funders.length; funderIndex++){
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0; 
        }
        //resetting the array
        funders = new address[](0);

        //withdrawing funds; 3 ways
        //transfer
        //payable(msg.sender).transfer(address(this).balance);

        //send
        //bool sendSuccess = payable(msg.sender).send(address(this).balance);
        //require(sendSuccess,"Send Failed");

        //call
        (bool callSucesss, ) = payable(msg.sender).call{value: address(this).balance}("");
        require (callSucesss,"Call failed");
    }


    //this is modifier
    modifier onlyOwner(){
     //require(msg.sender == i_owner,"Sender is not Owner");
     if (msg.sender != i_owner) {revert notOwner();} 
     _; //order of this matters
    }

    //yo 2 ta function le cahi automatically fund function ma lera janxa if msg.sender ma value xaina bhane
    receive() external payable{
        fund();
    }

    fallback() external payable{
        fund();
    }

}
