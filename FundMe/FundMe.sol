// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

//import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";
import {PriceConvertor} from "./PriceConvertor.sol";

contract FundMe {
    using PriceConvertor for uint256; // PriceConvertor can access all uint256
    uint256 public minimumUsd = 5e18;

    address[] public funders;
    mapping (address => uint256) public addressToAmountFunded;

    address public owned;

    constructor() {
        owned = msg.sender;
    }

    function fund() public payable {
        require( msg.value.getConversionRate() >= minimumUsd, "Did not send enough ETH"); // 1e18 = 1 ETH
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] +=  msg.value;
    }

    function withdraw () public onlyOwner {
        for(uint256 funderIndex = 0; funderIndex < funders.length; funderIndex) {
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }

        funders = new address[](0); // Reset the array

        /*
        // msg.sender = address
        // payable(msg.sender) = payable address
        payable(msg.sender).transfer(address(this).balance); // Send token way-1 (Transfer)

        //way-2 (Send)
        bool sendSuccess = payable(msg.sender).send(address(this).balance);
        require(sendSuccess, "Send failed");
        */

        //way-3 (Call)
        (bool callSuccess, ) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSuccess, "Send failed");
    }

    modifier onlyOwner() {
        require(msg.sender == owned, "Must be Owner!");
        _; // First require then rest of code

        /* if
        _;
        require(msg.sender == owned, "Must be Owner!");
        that means
        first code then require */
    }
}
