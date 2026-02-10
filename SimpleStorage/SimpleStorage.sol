// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18; //this is the solidity version

contract SimpleStorage {
    uint256 myFavouriteNumber;

    struct Person{ // Custom type name person
        uint256 favouriteNumber; // Index 0
        string name; // Index 1
    }

    Person[] public listOfPeople; // Dynamic array

    function store(uint256 _favouriteNumber) public {
        myFavouriteNumber = _favouriteNumber;
    }

    function retrive() public view returns (uint256){
        return myFavouriteNumber;
    }

    function addPerson(string memory _name, uint256 _favouriteNumber) public {
        listOfPeople.push(Person(_favouriteNumber, _name));
    }
}