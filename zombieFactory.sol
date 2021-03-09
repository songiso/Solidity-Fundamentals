pragma solidity >=0.5.0 <0.6.0;

import "./ownable.sol";



contract ZombieFactory is Ownable {
    
    event NewZombie(uint xombieId, string name, uint dna);
    uint dnaDigits = 16;
    uint dnaModula = 10 ** dnaDigits;
    uint coolDownTime = 1 days;
    
    struct Zombie {
        string name;
        uint dna;
        uint32 level;
        uint32 readyTime;
    }
    
    Zombie[] public zombies; 
    mapping(uint => address) public zombieToOwner;
    mapping(address => uint) onwerZombieCount;
    
    function _createZombie(string memory _name, uint _dna) internal{
       uint id = zombies.push(Zombie(_name, _dna, 1, uint32(now + coolDownTime))) - 1;
       zombieToOwner[id] = msg.sender;
       onwerZombieCount[msg.sender] ++;
       emit NewZombie(id, _name, _dna);
    }
    
    function _generateRandomDna(string memory _str) private view returns(uint){
        
        uint rand = uint(keccak256(abi.encodePacked(_str)));
        return rand % dnaModula;
    }
    
    function createRandomZombie(string memory _name) public{
        
        require(onwerZombieCount[msg.sender] == 0);
        uint rand = _generateRandomDna(_name);
        _createZombie(_name, rand);
    }
    
}

