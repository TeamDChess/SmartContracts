// SPDX-License-Identifier: MIT
pragma solidity ^0.7.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";
import "@openzeppelin/contracts/utils/Context.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract Board is Context, AccessControl, ERC721 {
  using Counters for Counters.Counter;
  
  Counters.Counter private _tokenID;
  
  mapping(uint256 => bool) private _burnedBoard;

  //Events

  event NewBoard(address player, uint256 idBoard);

  event Burn(address indexed _called, uint256 _idBoard);

  event Restore(address indexed _called, uint256 _idBoard);


  //Access Control
  
  bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");

  bytes32 public constant BURNER_ROLE = keccak256("BURNER_ROLE");

  
  constructor(
    string memory name,
    string memory symbol
  ) ERC721(name, symbol) public {
    _setBaseURI("https://items.dchess.net/boards/");

    //ROLE DEFINITION
    _setupRole(DEFAULT_ADMIN_ROLE, _msgSender());

    _setupRole(MINTER_ROLE, _msgSender());

    _setupRole(BURNER_ROLE, _msgSender());
  }

  function mintBoard(address user) public returns (uint256) {
    require(
      hasRole(MINTER_ROLE,_msgSender()),
      "THIS USER DOES NOT HAVE MINTER_ROLE");

    _tokenID.increment();

    uint256 newBoard = _tokenID.current();

    _mint(user,newBoard);

    emit NewBoard(user, newBoard);

    return newBoard;
  }

  function softBurnBoard(uint idBoard) public returns (bool) {
    require(
      hasRole(BURNER_ROLE,_msgSender()),
      "THIS USER DOES NOT HAVE BURNER_ROLE");

    require(
      _exists(idBoard),
      "THIS BOARD DOES NOT EXIST");

    _burnedBoard[idBoard] = true;

    emit Burn(_msgSender(), idBoard);

    return true;
  }

  function restoreBoard(uint idBoard) public returns (bool) {
    require(
      hasRole(DEFAULT_ADMIN_ROLE,_msgSender()),
      "THIS USER DOES NOT HAVE ADMIN_ROLE");

    require(
      _exists(idBoard),
      "THIS BOARD DOES NOT EXIST");

    _burnedBoard[idBoard] = false;

    emit Restore(_msgSender(), idBoard);

    return true;
  }

  function isBurned(uint256 idBoard) public view virtual returns(bool) {
    return _burnedBoard[idBoard];
  } 

  function _beforeTokenTransfer(address from, address to, uint256 idBoard) internal virtual override(ERC721) { 
    require(_burnedBoard[idBoard] == false, "BOARD IS BURNED");
  }

  function changeURI(string memory newUri) public virtual {
    require(
      hasRole(DEFAULT_ADMIN_ROLE,_msgSender()),
      "THIS USER DOES NOT HAVE ADMIN_ROLE");
    
    _setBaseURI(newUri);
  }
  
}
