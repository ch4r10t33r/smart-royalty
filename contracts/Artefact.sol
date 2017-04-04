pragma solidity ^0.4.0;

import 'MyMap.sol';
//import "github.com/Arachnid/solidity-stringutils/strings.sol";

contract Artefact {
  address owner;
  string ARTEFACT_CODE_STRING; //encoded string representation that identifies the artefact uniquely
  string ARTEFACT_NAME;
  //mapping(address=>uint) commission;

  MyMap.MyMap commission;

  function Artefact(address _owner,string _enmfId, string _name) {
    if(msg.sender != _owner) {
      throw;
    }
    owner = _owner;
    ARTEFACT_CODE_STRING = _enmfId;
    ARTEFACT_NAME = _name;
  }

  function addRoyalty(address receiver,uint amount) {
    MyMap.insert(commission, receiver, amount);
  }

  function transferOwner(address newOwner) {
    if(owner != msg.sender) {
      throw;
    }
    owner = newOwner;
  }

  function payCommission(uint amt) payable {
    uint comm = 0;
    uint cum = 0;
    for (uint i = 0; i < MyMap.size(commission); i++)
    {
      comm = (amt * MyMap.getValue(commission,i)) / 100;
      cum += comm;
      if(!MyMap.getKey(commission,i).send(comm))
        throw;
    }
    amt = amt - comm;
    if (!owner.send(amt))
      throw;
  }
}
