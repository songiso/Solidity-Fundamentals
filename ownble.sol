pragma solidity >=0.5.0 <0.6.0;

contract Ownable{
    
    address private _owner;
    event OwnerShipTransferred(
        address indexed previousOwner,
        address indexed newOwner
        );
}