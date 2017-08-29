pragma solidity ^0.4.15;

import "./NameReg.sol";
import "./NameRegEnabled.sol";

contract PermissionsDb is NameRegEnabled {
    mapping (address => uint8) public permissions;

    function setPermission(address addr, uint8 permLv) returns (bool) {
        if (nameRegAddr != 0x0) {
            address permCtr = NameReg(nameRegAddr).contracts("permctr");
            if (msg.sender == permCtr) {
                permissions[addr] = permLv;
                return true;
            }
                return false;
        }
        return false;
    }
}