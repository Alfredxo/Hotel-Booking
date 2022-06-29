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
    address owner;
    uint timestamp;
   }
  
  Occupants[] Bookers;

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

  function Booking(uint Checkout) external payable onlyIfVacant cost(1 ether) {
     currentStatus = status.occupied;
     Owner.transfer(msg.value);
     checkoutTime = Checkout;
     Bookers.push(Occupants(msg.sender, block.timestamp));

     emit Booked(msg.sender, msg.value);
    }

    function makeVacant() public onlyIfOccupied {
        require( block.timestamp >= checkoutTime , "Not Checkout Date" );
        currentStatus = status.vacant;
        
    }
    
    function getAllOccupants() public view returns(Occupants[] memory) {
       return Bookers;
    }

    
}