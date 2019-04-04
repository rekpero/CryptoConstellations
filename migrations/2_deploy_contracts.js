var CryptoConstellation = artifacts.require("./CryptoConstellationCore.sol");

module.exports = function(deployer) {
  deployer.deploy(CryptoConstellation);
};
