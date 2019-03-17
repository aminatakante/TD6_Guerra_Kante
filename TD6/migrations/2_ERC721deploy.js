var MyContract = artifacts.require("./contracts/ERC721.sol");

module.exports = function(deployer) {
  deployer.deploy(MyContract);
};