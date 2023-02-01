// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

//Challenge - To recover/remove 0.001 ether from the simpleToken contract which is deployed by the factory contract
// named "Recovery". The problem comes when we get to know that the address of simple token contract is lost
// We don't know the address.
contract Recovery {
    //generate tokens
    function generateToken(string memory _name, uint256 _initialSupply) public {
        new SimpleToken(_name, msg.sender, _initialSupply);
    }
}

contract SimpleToken {
    string public name;
    mapping(address => uint) public balances;

    // constructor
    constructor(string memory _name, address _creator, uint256 _initialSupply) {
        name = _name;
        balances[_creator] = _initialSupply;
    }

    // collect ether in return for tokens
    receive() external payable {
        balances[msg.sender] = msg.value * 10;
    }

    // allow transfers of tokens
    function transfer(address _to, uint _amount) public {
        require(balances[msg.sender] >= _amount);
        balances[msg.sender] = balances[msg.sender] - _amount;
        balances[_to] = _amount;
    }

    // clean up after ourselves
    function destroy(address payable _to) public {
        selfdestruct(_to);
    }
}

////////////////////////////////////
///////////////SOLUTION/////////////
////////////////////////////////////

/**
 * We will create a function which  generated a contract address.
 * You can search on the internet about how the addresses of contract on ethereum are generated.
 * nonce1= address(uint160(uint256(keccak256(abi.encodePacked(bytes1(0xd6), bytes1(0x94), _origin, bytes1(0x01))))));
This is the algorithm for contract addresses.
 */

contract GetAddress {
    function getAddress(address sender) external pure returns (address) {
        //address addr= address(uint160(uint256(keccak256(abi.encodePacked(bytes1(0xd6), bytes1(0x94), sender, bytes1(0x80))))));
        address addr = address(
            uint160(
                uint256(
                    keccak256(
                        abi.encodePacked(
                            bytes1(0xd6),
                            bytes1(0x94),
                            sender,
                            bytes1(0x01)
                        )
                    )
                )
            )
        );
        return addr;
    }

    //We can pass the address of Factory contract here which is the contract address of Recover contract.because 
    // That is the creator of simpleToken contract.
}
