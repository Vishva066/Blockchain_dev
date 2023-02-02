// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract identity{

    address[] users;

    mapping(address => string) public username;

    function registeruser(string memory name) public {
        if(!(CheckUserExist(msg.sender)))
        {
            users.push(msg.sender);
            username[msg.sender] = name;
        }else{
        revert("You have already registered");
        }
    }

    function CheckUserExist(address add) public view  returns(bool res)  {
        res = false;
        for (uint i = 0; i < users.length; i++) {
            if (add == users[i]) {
                res = true;
            }
        }
        return res;
    }

}
