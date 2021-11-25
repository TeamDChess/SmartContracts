// SPDX-License-Identifier: MIT

pragma solidity ^0.7.0;

import "@openzeppelin/contracts/access/AccessControl.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/utils/Context.sol";

contract Queen is Context, AccessControl, ERC20{

  using SafeMath for uint256;

  bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");

  uint256 private maxSupply = 100000000 * 10 ** 18;

  //REAL ADDRESS
  address public constant TEAM_ADDRESS = 0xf6F862c2F1C8cFA1b546b81Df63A96B5FAa60F1e;
  address public constant INVESTOR_ADDRESS = 0x0aDD67cbBb8B6d8FA026d0ee2954e4CB45937954;
  address public constant ADVISORS_ADDRESS = 0x48b9EEF5241EE20CE47B0D1Cc24319d756c516A3;
  address public constant ECOSYSTEM_ADDRESS = 0x923E20d45CAedcA7235c85a469870a1B12D3447C;
  address public constant IDO_ADDRESS = 0x4bBdBcbAc4463643a46e93A0Af12aCe7B2F1d25b;
  address public constant AIRDROP_ADDRESS = 0x1bf2E7b695706FA542c21f8CF30dc4282379B744;


  constructor(
    string memory name,
    string memory symbol
  ) public ERC20(name,symbol) {

    //ROLE DEFINITION
    _setupRole(DEFAULT_ADMIN_ROLE, _msgSender());
    _setupRole(MINTER_ROLE, _msgSender());

    mint(TEAM_ADDRESS, maxSupply.div(100).mul(10));
    mint(INVESTOR_ADDRESS, maxSupply.div(100).mul(5));
    mint(ADVISORS_ADDRESS, maxSupply.div(100).mul(10));
    mint(ECOSYSTEM_ADDRESS, maxSupply.div(100).mul(10));
    mint(IDO_ADDRESS, maxSupply.div(100).mul(7));
    mint(AIRDROP_ADDRESS, maxSupply.div(100).mul(3));
  }

  function mint(address to, uint256 amount) public virtual {
    require(
      hasRole(MINTER_ROLE,_msgSender()),
      "THIS USER DOES NOT HAVE MINTER_ROLE");

    require(
      totalSupply().add(amount) <= maxSupply,
      "MAXSUPPLY EXCEEDED");

    _mint(to, amount);
  }

  function burn(uint256 amount) public virtual {
    _burn(_msgSender(), amount);
  }

}