// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

//import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";
import {PriceConvertor} from "./PriceConvertor.sol";

contract FundMe {
    using PriceConvertor for uint256; // PriceConvertor can access all uint256
    uint256 public minimumUsd = 5e18;

    address[] public funders;
    mapping (address => uint256) public addressToAmountFunded;

    function fund() public payable {
        require( msg.value.getConversionRate() >= minimumUsd, "Did not send enough ETH"); // 1e18 = 1 ETH
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] = addressToAmountFunded[msg.sender] + msg.value;
    }

    //function withdraw () public {}

    
}
