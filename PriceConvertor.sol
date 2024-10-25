//PriceConvertor Library

// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

library PriceConverter {
    function getprice() internal view returns(uint256){
        //Address that holds updated price of eth from chainlink 0x694AA1769357215DE4FAC081bf1f309aDC325306
        //ABI 
        AggregatorV3Interface pricefeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        (,int256 price,,,)=pricefeed.latestRoundData(); //Price of ETH in USD 
        return uint256(price*1e10);
    }

    function getConversionRate(uint256 ethAmount) internal view returns(uint256){
        uint256 ethPrice = getprice();
        uint256 ethamountInUsd = (ethPrice * ethAmount) / 1e18; //always multiply before divide
        return(ethamountInUsd);
    }
}
