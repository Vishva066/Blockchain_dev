//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract SelfDestruct {
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    // Function to destroy the contract and send remaining Ether to a specified address
    function destroy(address payable recipient) public {
        require(msg.sender == owner, "Only the owner can call this function");
        selfdestruct(recipient);
    }
}
