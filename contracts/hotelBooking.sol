// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.1;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/PullPayment.sol";
import "@openzeppelin/contracts/security/Pausable.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

contract hotelBooking is Ownable, Pausable, PullPayment, ReentrancyGuard {
   
   event Booked(address _buyer, uint _value);

   address payable immutable Owner;
   uint internal checkoutTime;
   
  enum status {
    vacant,
    occupied
   }

  struct Occupants {
    uint id;
    string name;
    address owner;
    uint timestamp;
   }
  
  mapping (uint => Occupants) numberOfOccupants;
  uint totalOccupants;

   status public currentStatus;

   constructor() {
    Owner = payable(msg.sender);
    currentStatus = status.vacant;
   } 

   modifier onlyIfVacant() {
    require(currentStatus == status.vacant, "Currently Occupied");
    _;
   }

   modifier onlyIfOccupied() {
    require(currentStatus == status.occupied, "Already Vancant");
    _;
   }

   modifier cost(uint amount) {
   
   require(msg.value >= amount, "Not Enough Paid");
   _;
   }

  function Booking(uint Checkout, string memory name) 
  external 
  payable 
  nonReentrant
  whenNotPaused
  onlyIfVacant 
  cost(1 ether) 
    {
     currentStatus = status.occupied;
     Owner.transfer(msg.value);
     checkoutTime = Checkout;
     numberOfOccupants[totalOccupants] = Occupants(totalOccupants, name, msg.sender, block.timestamp);
     totalOccupants++;

     emit Booked(msg.sender, msg.value);
    }

    function makeVacant() public 
    onlyIfOccupied 
    
    {
        require( block.timestamp >= checkoutTime , "Not Checkout Date" );
        currentStatus = status.vacant;
    }
    
    function getOccupant(uint id) public 
    view 
    returns(string memory name, address owner) 
    {
     name = numberOfOccupants[id].name;
     owner = numberOfOccupants[id].owner;
    }

    
}