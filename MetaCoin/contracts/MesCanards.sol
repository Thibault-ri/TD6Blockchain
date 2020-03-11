pragma solidity ^0.4.19;

import "./node_modules/@openzeppelin/contracts/ownership/ownable.sol";
import "./node_modules/@openzeppelin/contracts/math/safemath.sol";
import "./node_modules/@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "./node_modules/@openzeppelin/contracts/GSN/Context.sol";


contract Canard is Ownable,Context, ERC721 {

  using SafeMath for uint256;

  event NewCanard(uint canardId, string name, uint age);


  struct Canard {
    string name;
    string headcolor;
    uint32 age;
    string race;
    string bodycolor;
  }

  Canard[] public canards;

  mapping (uint => address) public canardToOwner;
  mapping (address => uint) ownerCanardCount;

  function declareAnimal(string _name,string _hcol, uint _age,string _race, string _bcol) internal {
    uint id = canards.push(Canard(_name, _age, 1, uint32(now + cooldownTime), 0, 0)) - 1;
    canardToOwner[id] = msg.sender;
    ownerCanardCount[msg.sender]++;
    NewCanard(id, _name,_hcol, _age,_race,_bcol);
  }

  
  function deadAnimal(uint256 canardId) public {
        require(_isApprovedOrOwner(_msgSender(), canardId), "ERC721Burnable: caller is not owner nor approved");
        _burn(canardId);
    }


  /*function createRandomCanard(string _name) public {
    require(ownerCanardCount[msg.sender] == 0);
    uint randAge = ;
    
    _createCanard(_name,hcol, randAge,race,bcol);
  }*/

}