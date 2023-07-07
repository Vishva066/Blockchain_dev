//SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

//contract to see how to find the lenght of the mapping and how to iterate through the mapping
//get random values at different positions from the mapping
contract LoopMapping{


    mapping(address => uint) public balances;

    //mappings doesn't support lenght function or iteration.
    //we have to keep track of the key
    //we need to track if the key is inserted or not, here the key is address type so we make a address to bool mapping to track the key
    mapping (address => bool) public isInserted;

    //we also needs to store all the keys that are inserted so we declare address array as key is address type
    address[] public keys;

    //fucntion to set balance of mapping
    function setBalance(address _key, uint _value)public {

        balances[_key] = _value;

        //if isInserted of a particular address is false
        if(! isInserted[_key]){

            //set isInserted to true, this is to prevent a key that has been inserted once to keys array not be inserted again
            isInserted[_key] = true;

            //push the _key address to keys array
            keys.push(_key);
        }
    }

    //function to get size or length of mapping, this is actually equal to lenght of keys array
    function getMappingSize()public view returns (uint){
         uint mappingSize = keys.length;
         return mappingSize;

    }

    //fucntions to iterate and get values from mapping

    //function to first value of mapping
    function first()public view returns(uint){

        //keys[0] contains key (address) of first item in mapping
        return balances[keys[0]];
    }

    //function to last value of mapping
    function last()public view returns(uint){

        //keys[keys.length-1] contains key (address) of last item in mapping
        return balances[keys[keys.length-1]];
    }

    //function to any value at any index of mapping
    function anyValue(uint _index)public view returns(uint){

        //keys[_index] contains key (address) of i'th item in mapping
        return balances[keys[_index]];
    }




}
