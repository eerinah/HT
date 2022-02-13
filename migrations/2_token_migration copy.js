const CardToken = artifacts.require("CardToken");

module.exports = function (deployer, network, accounts) {
  deployer.deploy(CardToken, {gas: 4612388, from: accounts[0]});
};
