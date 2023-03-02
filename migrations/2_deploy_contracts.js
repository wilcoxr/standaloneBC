const Marketplace = artifacts.require("Marketplace");
//const LazyNFT = artifacts.require("LazyNFT");
module.exports = function(deployer) {
    deployer.deploy(Marketplace);
    //deployer.deploy(LazyNFT);
  };