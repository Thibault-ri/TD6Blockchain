pragma solidity ^0.4.19;

import "./node_modules/@openzeppelin/contracts/ownership/ownable.sol";
import "./node_modules/@openzeppelin/contracts/math/safemath.sol";
import "./node_modules/@openzeppelin/contracts/token/ERC721/ERC721Full.sol";

/// TODO : A remplacez avec par des descriptions natspec
contract CanardOwnership is ERC721 {

  using SafeMath for uint256;

  mapping (uint => address) canardApprovals;

  function balanceOf(address _owner) public view returns (uint256 _balance) {
    return ownerCanardCount[_owner];
  }

  function ownerOf(uint256 _tokenId) public view returns (address _owner) {
    return canardToOwner[_tokenId];
  }

  function _transfer(address _from, address _to, uint256 _tokenId) private {
    ownerCanardCount[_to] = ownerCanardCount[_to].add(1);
    ownerCanardCount[msg.sender] = ownerCanardCount[msg.sender].sub(1);
    canardToOwner[_tokenId] = _to;
    Transfer(_from, _to, _tokenId);
  }

  function transfer(address _to, uint256 _tokenId) public onlyOwnerOf(_tokenId) {
    _transfer(msg.sender, _to, _tokenId);
  }

  function approve(address _to, uint256 _tokenId) public onlyOwnerOf(_tokenId) {
    canardApprovals[_tokenId] = _to;
    Approval(msg.sender, _to, _tokenId);
  }

  function takeOwnership(uint256 _tokenId) public {
    require(canardApprovals[_tokenId] == msg.sender);
    address owner = ownerOf(_tokenId);
    _transfer(owner, msg.sender, _tokenId);
  }
}
