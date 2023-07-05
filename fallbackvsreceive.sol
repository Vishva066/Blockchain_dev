// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

//contract to differentiate between fallback() and receive()
contract FallbackVsReceive{

    //event to see which function was logged
    event Log(string functionUsed, uint value, bytes data);

    //fallback function is used when there data send with the transaction
    fallback() external payable{
        emit Log("fallback()", msg.value, msg.data);
    }

    //receive function is used when there no data send with the transaction
    receive() external payable{
        emit Log("receive()", msg.value,"");
    }

} 
