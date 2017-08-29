pragma solidity ^0.4.15;

import "./NameReg.sol";
import "./NameRegEnabled.sol";
import "./PermissionsDb.sol";

contract PermissionsController is NameRegEnabled {

    function isManager() constant returns (bool) {
        if (nameRegAddr != 0x0) {
            address mg = NameReg(nameRegAddr).contracts("manager");
            return mg == msg.sender;
        }
        return false;
    }

    function setPermission (address addr, uint8 permLv) returns (bool) {
        if(!isManager()){
            return false;
        }
        address permdb = NameReg(nameRegAddr).contracts("permdb");
        if (permdb == 0x0) {
            return false;
        }
        return PermissionsDb(permdb).setPermission(addr, permLv);
    }

    function getPermission (address addr) returns (uint8) {
        address permdb = NameReg(nameRegAddr).contracts("permdb");
        require (permdb != 0x0);
        return PermissionsDb(permdb).permissions(addr);
    }
}