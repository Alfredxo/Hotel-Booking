// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.1;

import "./hotelBooking.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract ERC20Payment is hotelBooking {
   IERC20 token;

   constructor()  
    {
        token = IERC20(0x62D62D73C27E6240165ee3A97C6d1532c0dD0b42);
    }

    function Approvetokens(uint256 _tokenamount) public returns(bool)
     {
       token.approve(address(this), _tokenamount);
       return true;
     }

     function GetAllowance() public view returns(uint256)
      {
       return token.allowance(msg.sender, address(this));
      }
   
   function AcceptPayment(uint256 _tokenamount) public returns(bool) 
    {
       require(_tokenamount > GetAllowance(), "Please approve tokens before transferring");
       token.transfer(address(this), _tokenamount);
       return true;
    }
}