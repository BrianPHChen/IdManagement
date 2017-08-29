pragma solidity ^0.4.15;

import "./NameRegEnabled.sol";

contract NameReg {
    address public owner;

    mapping (bytes32 => address) public contracts;

    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }

    function NameReg() {
        owner = msg.sender;
    }

    function addContract(bytes32 name, address addr) onlyOwner returns (bool) {
        NameRegEnabled nre = NameRegEnabled(addr);
        if(!nre.setNameRegAddress(this)) { return false;}
        contracts[name] = addr;
        return true;
    }

    function removeContract(bytes32 name) onlyOwner returns (bool) {
        if (contracts[name] == 0x0) {
            return false;
        }
        contracts[name] = 0x0;
        return true;
    }

    function getContract(bytes32 name) constant returns (address) {
        return contracts[name];
    }

    function remove() onlyOwner {
        address mg = contracts["manager"];
        address idctr = contracts["idctr"];
        address permctr = contracts["permctr"];
        address permdb = contracts["permdb"];

        if (mg != 0x0) {NameRegEnabled(mg).remove();}
        if (idctr != 0x0) {NameRegEnabled(idctr).remove();}
        if (permctr != 0x0) {NameRegEnabled(permctr).remove();}
        if (permdb != 0x0) {NameRegEnabled(permdb).remove();}
        
        selfdestruct(owner);
    }
}