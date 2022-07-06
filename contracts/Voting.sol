// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.1;

import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Ballot is Ownable {


  address public chairperson;

  mapping (uint => candidate) public candidateLookup;
  uint candidateCount;

  constructor() {
    chairperson == msg.sender;
  }

  struct candidate {
    uint id;
    string name;
    uint voteCount;
  }

  function addCandidate(string memory name) public onlyOwner {
    candidateLookup[candidateCount] = candidate(candidateCount, name, 0);
    candidateCount++;
  }

  function getcandidate() external view returns(string memory name, uint voteCount) {
    name = candidateLookup[id].name;
    voteCount = candidateLookup[id].voteCount;
  }

  function allCandiates(uint id) external view returns(string[] memory, uint[] memory) {
    string[] memory names = new string[](candidateCount);
    uint[] memory voteCounts = new uint[](candidateCount);
    for(uint i = 0; i < candidateCount; i++) {
       names[i] = candidateLookup[i].name;
       voteCount[i] = candidateLookup[i].voteCount;
    }
    return(names, voteCounts);
  }

  function vote(uint id) {
    require(!voterLookup[msg.sender]);
    require(id >= 0 && id <= candidateCount-1);
    candidateLookup[id].voteCount++;
    emit voteEvent(uint id);

  }

  event voteEvent(uint indexed id);  
}