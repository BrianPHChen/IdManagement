pragma solidity ^0.4.15;

import "./NameReg.sol";
import "./NameRegEnabled.sol";

contract IdController is NameRegEnabled {
    mapping (address => bytes32) public id;

    function isManager() constant returns (bool) {
        if (nameRegAddr != 0x0) {
            address mg = NameReg(nameRegAddr).contracts("manager");
            return mg == msg.sender;
        }
        return false;
    }

    function setId(address addr, bytes32 name) returns (bool){
        if (!isManager()) { return false ;}
        id[addr] = name;
        return true;
    }
}