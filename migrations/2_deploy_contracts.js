var IDCTR = artifacts.require("./IdController.sol");
var MANAGER = artifacts.require("./Manager.sol");
var NAMEREG = artifacts.require("./NameReg.sol");
var PERMCTR = artifacts.require("./PermissionsController.sol");
var PERMDB = artifacts.require("./PermissionsDb.sol");

module.exports = function(deployer) {
  deployer.deploy(IDCTR);
  deployer.deploy(MANAGER);
  deployer.deploy(NAMEREG);
  deployer.deploy(PERMCTR);
  deployer.deploy(PERMDB);
};
