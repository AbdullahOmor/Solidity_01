// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {SimpleStorage} from "./SimpleStorage.sol";

contract StorageFactory{
    //SimpleStorage public simpleStorage; // SimpleStorage = type(contract name / variable type) && simpleStorage = name(like variable name)
    SimpleStorage[] public listOfSimpleStorageContract;
    function createSimpleStorageContract() public {
        //simpleStorage = new SimpleStorage(); //"new" keyword is used to define the new contract
        SimpleStorage newSimpleStorage = new SimpleStorage();
        listOfSimpleStorageContract.push(newSimpleStorage);
    }

    function sfStore(uint256 _simpleStorageIndex, uint256 _newSimpleStorageNumber) public{
        // Address
        // ABI - Application Binary Interface
        SimpleStorage mySimpleStorage = listOfSimpleStorageContract[_simpleStorageIndex];
        mySimpleStorage.store(_newSimpleStorageNumber);
    }
    function sfRetrive(uint256 _simpleStorageIndex) public view returns(uint256){
        SimpleStorage mySimpleStorage = listOfSimpleStorageContract[_simpleStorageIndex];
        return mySimpleStorage.retrive();
    }
}