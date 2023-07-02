//SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

//a contract to create a new contract from another contract
//the function is gooing to deploy the contract 'Account' when it is called
contract Account{

    address public bank;
    address public owner;

    constructor(address _owner)payable{
        bank = msg.sender;
        owner = _owner;
    }
}

//using this contract and its function to create a new contract from 'Account' and the function is gooing to deploy
//the contract 'Account' when it is called
//naming convention : name of deplooyed contract + Factory
contract AccountFactory{

    //creating a variable 'account' of type 'Account'
    Account public account;

    //creating an array 'accounts' of typen 'Account'
    Account[] public accounts;

    //this function deploys contract 'Account'
    //this function is payable , so if we send 200 wei to function, 100 wei will be send to 'Account' contract as we mentioned below
    function createAccount(address _owner)external payable{

        //to call the contract we use 'new' and followed by name of the contract to be deployed
        //pass the value for the constructor
        //we can see that the 'Account' contract is payable so to send ether to it we declare value here
        account = new Account{value : 100}(_owner);

        //pushing the account variable into accounts array
        accounts.push(account);


    }
}
