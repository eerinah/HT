const CardToken = artifacts.require("CardToken");

module.exports = function (deployer) {
  deployer.deploy(CardToken);
};
