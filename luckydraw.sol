// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;


contract luckydraw{
    address payable[] private uaddr;

    address  public owner;
    uint initialsum = 2 ether;
    mapping (address => uint)  private sum; 
     
     modifier initialfee(){
         require(msg.value== initialsum,"Entry is restricted only to participants who pay 2 ether.(Participants paying more than 2 ether are also not accepted");
         _;
     }
     
     modifier onlyOwner (){
         require(msg.sender == owner, "Not host");
         _;
     }
     constructor () {
         owner =msg.sender;
     }

     
     function adduser() external payable initialfee noOwner{
         if (!(CheckUserExist(msg.sender))){
            uaddr.push(payable(msg.sender));
         }
         else
         {
             revert("Sorry,You already participated can't participate twice");
         }
     }

      function totalwinnings() public view returns(uint){
            return address(this).balance;
      }
     
     function CheckUserExist(address add) public view  returns(bool res)  {
        res = false;
        for (uint i = 0; i < uaddr.length; i++) {
            if (add == uaddr[i]) {
                res = true;
            }
        }
        return res;
    }
     
     
     modifier noOwner() {
         require(msg.sender != owner , "Host not allowed to participate");
         _;
     }
     
     
     function rand() internal view returns (uint) {
         return uint(keccak256(abi.encodePacked(block.timestamp,block.difficulty,msg.sender))) % uaddr.length;
     }
     
      function winner() payable public onlyOwner returns(address){
       uint winningindex = rand();
       uaddr[winningindex].transfer(address(this).balance);
       return uaddr[winningindex];
     }
    
}
