// SPDX-License-Identifier: MIT

pragma solidity ^0.8.6;

//contract name is MyFirstContract
contract UserDetails {


    string private name;
    uint private age;
    string private profession;

    function setName(string memory newName) public {
        name = newName;
    }

    function getName () public view returns (string memory) {
        return name;
    }
    
    function setAge(uint newAge) public {
        age = newAge;
        
    }

    function getAge () public view returns (uint) {
        return age;
    }

    function setProfession (string memory newProfession) public {
        profession = newProfession; 
    }

    function getProfession () public view returns (string memory) {
        return profession;
    }
    
}
