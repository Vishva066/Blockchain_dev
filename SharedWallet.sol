//A shared wallet where:
//anyone can deposit funds
//only owner can withdraw unlimited amount
//only owner can set allowance amount to addresses
//other addresses can only withdraw upto their allowance amount


//SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

//importing contract that sets msg.sender as owner and gives other functionalities
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";

//creating another contract for allowance
contract Allowance is Ownable{

    //Add an event to show the allowance change
    //here indexed is used so that we can search the address from the event chain
    event AllowanceChanged(address indexed _byWho, address indexed _forWhom, uint _oldAmount, uint _newAmount);

    //mapping to map address to corresponding allowance
    mapping(address => uint) public allowance;

    //function to set allowance to addresses
    //the onlyOwner modifier here comes from openzepplin ownable.sol
    function setAllowance(address _to, uint  _amount)public onlyOwner{

        //emit event to show allowance change
        emit AllowanceChanged(msg.sender, _to, allowance[_to], _amount);

        allowance[_to] = _amount;
    }


    //funtion to reduce allowance
    function reduceAllowance(address _to, uint _amount)internal{

        //emit event to show allowance change
        emit AllowanceChanged(msg.sender, _to, allowance[_to], (allowance[_to] - _amount));


        allowance[_to] -= _amount;
    }

    //function to disable the renounceOwnership()  function
    function renounceOwnership() override public pure{
        revert("Can't do this task");
    }
}


//contract for shared wallet
contract SharedWallet is Allowance{

    //add events to show money received and withdrawn
    event moneyReceived(address indexed _fromWho, uint _amount);
    event moneySent(address indexed _toWhom, uint _amount);

    //as we are not sending any data (in calldata of low level transaction) with the ether we can use recieve()
    receive() external payable{

        //emit moneyReceived event here
        emit moneyReceived(msg.sender, msg.value);
    }


    // only owner or allowed address
    modifier ownerOrAllowed(uint _amount) {

        //here the owner() is from Ownable.sol
        require(msg.sender == owner() ||allowance[msg.sender] >= _amount, "You are not allowed");
        _;
    }


    //withdraw by allowance allowed or any amount by owner
    //can pass the _amount from withdraw() to ownerOrAllowed()
    function withdraw(address payable _to,uint _amount)public ownerOrAllowed(_amount){

        //lets give a custom error message if there is no money im contract
        require(address(this).balance >= _amount, "Not enough funds in the contract");

        //reduce allowance
        reduceAllowance(msg.sender,_amount);

        _to.transfer(_amount);

        //emit event to show money sent
        emit moneySent(_to, _amount);
    }


}
