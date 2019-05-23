pragma solidity ^0.4.24;

// solc src/contracts/Storage.sol --abi -o src/contracts/Storage.json

contract Storage {
  uint256 public value;

  event Created(uint256 value);

  function create(uint256 _value) external {
    value = _value;
    
    emit Created(value);
  }
}