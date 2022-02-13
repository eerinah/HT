const Market = artifacts.require("Market");
const Card = artifacts.require("CardToken");
const truffleAssert = require('truffle-assertions');

contract("Market", accounts => {
    let market;
    let card;

    beforeEach(async function() {
        market = await Dex.deployed();
        card = await Link.deployed();
    });

    describe("Should allow a new Card to be added to the market", function() {
        it("Adds a new Card to the market")
    })

    describe()

    describe()

    describe()
});
