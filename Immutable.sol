// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract Immutable{

    //we can use the immutable keyword for declaring constants
    //this saves a lot of gas
    //these variables can only be initialized once and during contract deployment
    //So these are usually used with constructors

    //lets make our owner immutable, lets make owner payable
    address payable immutable owner;

    //constructor to set owner to msg.sender
    constructor (){
        owner = payable(msg.sender);
    }

}
