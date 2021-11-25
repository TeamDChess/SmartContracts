// SPDX-License-Identifier: MIT

pragma solidity ^0.7.0;

import "@openzeppelin/contracts/access/AccessControl.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/utils/Context.sol";

contract King is Context, AccessControl, ERC20{

  //Access Control

  bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");

  constructor(
    string memory name,
    string memory symbol
  ) public ERC20(name,symbol){

    _setupRole(DEFAULT_ADMIN_ROLE, _msgSender());

    _setupRole(MINTER_ROLE, _msgSender());
  }

  function mint(address to, uint256 amount) public virtual {
    require(
      hasRole(MINTER_ROLE,_msgSender()),
      "THIS USER DOES NOT HAVE MINTER_ROLE");

    _mint(to, amount);
  }

  function burn(uint256 amount) public virtual {
    _burn(_msgSender(), amount);
  }

}
