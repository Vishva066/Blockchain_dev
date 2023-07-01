//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract PureVsView{

    //declaring a state variable
    uint num = 10;

    //view function example
    function viewFunction()public view returns(uint){

        //returning a state varible ,ie , reading data from the blockchain
        return num;
    }

    //view function example2
    function viewFunction(uint x)public view returns(uint){

        //returning a state varible ,ie , reading data from the blockchain and adding it to local variable
        return num + x;
    }

    //pure function example
    function pureFunction(uint x , uint y)public pure returns(uint){

        //returning only local variables , no state variable
        return x + y;
    }

    //pure function example2
    function pureFunction2()public pure returns(uint){

        //returning just a vlue
        return 1;
    }
}

//Pure and View both are read functions. They don't consume gas and change the blockchain state.

//View can read data from the blockchain. Pure can't read data from the blockchain , they can read local variables.
