// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

//Challenge :- To unlock this vault

contract Vault {
  bool public locked;
  bytes32 private password;

  constructor(bytes32 _password) {
    locked = true;
    password = _password;
  }

  function unlock(bytes32 _password) public {
    if (password == _password) {
      locked = false;
    }
  }
}

/////SOLUTION///////

  
// Here we need to find the password which is stored in the bytes32 variable password
//as this is stored in a private variable we can not access it directly coz this is private
// But this is a vulnerability in solidity that we can access the private variables. 
//Head over to AttackVault.js in the scripts folder. We can get the password from there and call the
//unlock function to unlock the vault.