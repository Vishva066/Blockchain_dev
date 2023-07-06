//SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

//3 contracts which inherits one other and some functions are modifiable
contract A{

    //we use a keyword virtual for function f1 and f2 to make it modifiable in the inherited contract
    function f1()public pure virtual returns(string memory){
       return "A";
    }

    function f2()public pure virtual returns(string memory){
        return "A";
    }

    function f3()public pure returns(string memory){
        return "A";
    }

}

contract B is A{

    //we use a keyword override for function f1 and f2 to make it modifiable as it is inherited from contract A
    //we use virtual for f1() as its inheritted and modified in contract C
    function f1()public pure override virtual returns(string memory){
            return "B";
        }

    function f2()public pure override returns(string memory){
            return "B";
        }

        //function f3 will be automatically available in the contract
}

contract C is B{

    //lets take the function f1 from B and modify it here
    function f1()public pure override returns(string memory){
            return "C";
    }

}
