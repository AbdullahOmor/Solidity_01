// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract Consumer {
    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }

    function deposit() public payable {}
}

contract Wallet {
    address payable public owner;

    mapping (address => uint256) public allowance;
    mapping (address => bool) public isAllowedToSend;

    mapping (address => bool) public gurdians;
    address payable public nextOwner;
    mapping (address => mapping (address => bool)) nextOwnerGurdianVoteBool;
    uint256 guardianResetCount;
    uint256 public constant confirmationsFromGuardianForReset = 3;

    constructor() {
        owner = payable (msg.sender);
    }

    function setGurdian(address _gurdian, bool _isGurdian) public {
        require(msg.sender == owner, "You are not the Owner");
        gurdians[_gurdian] = _isGurdian;
    }

    function proposeNewOwner(address payable _newOwner) public {
        require(gurdians[msg.sender], "You are not the Guardian of this wallet");
        require(nextOwnerGurdianVoteBool[_newOwner][msg.sender] == false, "You already voted");
        if  (_newOwner != nextOwner) {
            nextOwner = _newOwner;
            guardianResetCount = 0;
        }

        guardianResetCount++;

        if (guardianResetCount >= confirmationsFromGuardianForReset) {
            owner = nextOwner;
            nextOwner = payable (address(0));
        }
    }

    function setAllowance(address _for, uint256 _ammount) public {
        require(msg.sender == owner, "You are not the Owner");
        allowance[_for] = _ammount;

        if(_ammount > 0) {
            isAllowedToSend[_for] = true;
        } else {
            isAllowedToSend[_for] = false;
        }
    }

    function transfer(address payable _to, uint256 _ammount, bytes memory _payload) public returns (bytes memory) {
        // require(msg.sender == owner, "You are not the owner");
        if(msg.sender != owner) {
            require(isAllowedToSend[msg.sender], "You are not allowed to send");
            require(allowance[msg.sender] >= _ammount, "You have not enough allowance");

            allowance[msg.sender] -= _ammount;
        }

        (bool success, bytes memory returnData) = _to.call{value: _ammount}(_payload);
        require(success, "Call was not sucessfull");
        return returnData;
    }

    receive() external payable {}
}