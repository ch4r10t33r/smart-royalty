pragma solidity ^0.4.0;

library MyMap
{
  struct entry {
      // Equal to the index of the key of this item in keys, plus 1.
      uint keyIndex;
      uint value;
  }

  struct MyMap {
      mapping(address => entry) data;
      address[] keys;
  }

  function insert(MyMap storage self, address key, uint value) internal returns (bool replaced) {
      entry storage e = self.data[key];
      e.value = value;
      if (e.keyIndex > 0) {
          return true;
      } else {
          e.keyIndex = ++self.keys.length;
          self.keys[e.keyIndex - 1] = key;
          return false;
      }
  }

  function remove(MyMap storage self, address key) internal returns (bool success) {
      entry storage e = self.data[key];
      if (e.keyIndex == 0)
          return false;

      if (e.keyIndex < self.keys.length) {
          // Move an existing element into the vacated key slot.
          self.data[self.keys[self.keys.length - 1]].keyIndex = e.keyIndex;
          self.keys[e.keyIndex - 1] = self.keys[self.keys.length - 1];
          self.keys.length -= 1;
          delete self.data[key];
          return true;
      }
  }

  function contains(MyMap storage self, address key) internal constant returns (bool exists) {
      return self.data[key].keyIndex > 0;
  }

  function size(MyMap storage self) internal constant returns (uint) {
      return self.keys.length;
  }

  function get(MyMap storage self, address key) internal constant returns (uint) {
      return self.data[key].value;
  }

  function getValue(MyMap storage self, uint idx) internal constant returns (uint) {
    return self.data[self.keys[idx]].value;
  }

  function getKey(MyMap storage self, uint idx) internal constant returns (address) {
      return self.keys[idx];
  }
}
