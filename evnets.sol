// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Election {
    // Enum to represent different candidate options
    enum Candidate { Alice, Bob, Carol }
    
    // Event to log when a vote is cast
    event VoteCasted(address indexed voter, Candidate candidate);
    
    // Mapping to store the vote count for each candidate
    mapping(Candidate => uint256) public voteCount;
    
    // Function to cast a vote for a candidate
    function vote(Candidate candidate) public {
        // Increase the vote count for the chosen candidate
        voteCount[candidate]++;
        
        
        // Emit the VoteCasted event
        emit VoteCasted(msg.sender, candidate);
    }
}





