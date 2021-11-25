const Queen = artifacts.require("Queen.sol");

	module.exports = function (deployer, network) {
        if(network == 'bsc'){
  		    deployer.deploy(Queen, "Queen", "QUEEN");
        }
	};
