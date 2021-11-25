const Board = artifacts.require("Board.sol");

	module.exports = function (deployer, network) {
        if(network == 'bsc'){
  		    deployer.deploy(Board,"DChess Boards","BOARD");
        }
	};
