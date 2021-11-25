const King = artifacts.require("King.sol")

module.exports = async function (deployer,network) {
    if(network == "bsc"){
        await deployer.deploy(King,"King","KING");
    }
}