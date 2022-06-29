// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.1;

import "./hotelBooking.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract ERC20Payment is hotelBooking {
   
   bytes32[] public whitelistedSymbols;
   mapping(bytes32 => address) public whitelistedTokens;
   mapping(address => mapping(bytes32 => uint256)) public balances;

   

   function whitelistToken(bytes32 symbol, address tokenAddress) external onlyOwner {

    whitelistedSymbols.push(symbol);
    whitelistedTokens[symbol] = tokenAddress;
  }

  function getWhitelistedSymbols() external view returns(bytes32[] memory) {
    return whitelistedSymbols;
  }

  function getWhitelistedTokenAddress(bytes32 symbol) external view returns(address) {
    return whitelistedTokens[symbol];
  }
  
  function payWithAltoken(uint256 amount, bytes32 symbol) external {
    balances[msg.sender][symbol] >= amount;
    IERC20(whitelistedTokens[symbol]).transferFrom(msg.sender, address(this), amount);
    
  }
}