pragma solidity ^0.4.15;

import "./NameReg.sol";
import "./NameRegEnabled.sol";
import "./IdController.sol";
import "./PermissionsController.sol";

contract Manager is NameRegEnabled{
    address public owner;
    uint8 constant ownerPermLv = 2;
    function Manager() {
        owner = msg.sender;
    }

    function setId(address addr, bytes32 name) returns (bool success){
        address idCtr = NameReg(nameRegAddr).contracts("idctr");
        address permCtr = NameReg(nameRegAddr).contracts("permctr");
        if (idCtr == 0x0) { return false;}
        if (PermissionsController(permCtr).getPermission(addr) < 1) {return false;}
        success = IdController(idCtr).setId(addr, name);
    }

    function getId(address addr) constant returns (bytes32) {
        address idCtr = NameReg(nameRegAddr).contracts("idctr");
        require (idCtr != 0x0);
        return IdController(idCtr).id(address(addr));
    }

    function setPermission(address addr, uint8 permLv) returns (bool) {
        address permCtr = NameReg(nameRegAddr).contracts("permctr");
        if (permCtr == 0x0) {return false;}
        uint8 userPerm = getPermission(msg.sender);
        if (userPerm < ownerPermLv && msg.sender != owner) { return false; }
        return PermissionsController(permCtr).setPermission(addr, permLv);
    }

    function getPermission(address addr) constant returns (uint8) {
        address permCtr = NameReg(nameRegAddr).contracts("permctr");
        require (permCtr != 0x0);
        return PermissionsController(permCtr).getPermission(addr);
    }
}