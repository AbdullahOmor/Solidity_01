// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract Wallet {
    address payable owner;

    mapping (address => uint256) public allowance;
    mapping (address => bool) public isAllowedToSend;
    constructor() {
        owner = payable (msg.sender);
    }

    function setAllowance(address _for, uint256 _ammount) public {
        
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