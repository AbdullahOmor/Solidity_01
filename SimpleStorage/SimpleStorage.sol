// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18; //this is the solidity version

contract SimpleStorage {
    uint256 public favouriteNumber;

    function store(uint256 _favouriteNumber) public {
        favouriteNumber = _favouriteNumber;
    }

    function retrive() public view returns (uint256){
        return favouriteNumber;
    }
}