const Market = artifacts.require("Market");

module.exports = function (deployer, network, accounts) {
  deployer.deploy(Market, {gas: 4612388, from: accounts[0]});
};
