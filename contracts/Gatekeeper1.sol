// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

//Challenge :- to pass all the require statements and become the entrant 

contract GatekeeperOne {
    address public entrant;

    modifier gateOne() {
        require(msg.sender != tx.origin);
        _;
    }

    modifier gateTwo() {
        require(gasleft() % 8191 == 0);
        _;
    }

    modifier gateThree(bytes8 _gateKey) {
        require(
            uint32(uint64(_gateKey)) == uint16(uint64(_gateKey)),
            "GatekeeperOne: invalid gateThree part one"
        );
        require(
            uint32(uint64(_gateKey)) != uint64(_gateKey),
            "GatekeeperOne: invalid gateThree part two"
        );
        require(
            uint32(uint64(_gateKey)) == uint16(uint160(tx.origin)),
            "GatekeeperOne: invalid gateThree part three"
        );
        _;
    }

    function enter(bytes8 _gateKey)
        public
        gateOne
        gateTwo
        gateThree(_gateKey)
        returns (bool)
    {
        entrant = tx.origin;
        return true;
    }
}

////////////////////////////////////////////////////////
/////////////////SOLUTION/////////////////////////////////
////////////////////////////////////////////////////////

contract Solve {

    
    //  require(uint32(uint64(_gateKey)) == uint16(uint64(_gateKey)), "GatekeeperOne: invalid gateThree part one");
    //   require(uint32(uint64(_gateKey)) != uint64(_gateKey), "GatekeeperOne: invalid gateThree part two");
    //   require(uint32(uint64(_gateKey)) == uint16(uint160(tx.origin)), "GatekeeperOne: invalid gateThree part three");
    /*
    
    k64 = uint64(gatekey);
Gatekeeper 3 passing confition.
    uint32(k64) =  uint16(uint160(myaddress)) = uint16(k64) != k64

    
    
    
    */
    GatekeeperOne gatekeeper;

    constructor(GatekeeperOne gate) {
        gatekeeper = gate;
    }

    function get() external {
        // return uint16( uint160(0x69A0d70271fb5C402a73125D95fadA17C55aD89A));\

        uint64 a = 9223372036854831258;

        // return (uint32(a), uint16(a));
        // return bytes8(a);
        uint256 gas = 8191 * 10 + 256;
       
            gatekeeper.enter{gas: gas}(bytes8(a));
        
    }
}
