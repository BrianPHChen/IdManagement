pragma solidity ^0.4.15;

contract NameRegEnabled {
    address nameRegAddr;

    function setNameRegAddress(address addr) returns (bool) {
        if (nameRegAddr != 0x0 && msg.sender != nameRegAddr) {
            return false;
        }
        nameRegAddr = addr;
        return true;
    }

    function remove() {
        if (msg.sender == nameRegAddr) {
            selfdestruct(nameRegAddr);
        }
    }
}