// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract TheBlockchainMessenger {
    uint256 public changeCount;
    address public owner;
    string public theMessage;

    constructor(){
        owner = msg.sender;
    }

    function getMessage(string memory _newMessage) public  {
        if(owner == msg.sender){
            changeCount++;
            theMessage = _newMessage;
        }
    }
}