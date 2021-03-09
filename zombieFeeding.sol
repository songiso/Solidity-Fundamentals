pragma solidity >=0.5.0 <0.6.0;

import "./ZombieFactory";




contract KittyInterface{
    
     function getKitty(uint256 _id) external view returns(
        bool isGestating,
        bool isReady,
        uint256 cooldownIdex,
        int256 nextActionAt,
        int256 siringWithId,
        int256 birthTime,
        int256 matronId,
        int256 sireId,
        int256 generation,
        int256 genes
        );
    
}

contract ZombieFeeding is ZombieFactory{
    
    KittyInterface kittyContract;
    
    function setKittyContrctAdress(address _adress) external onlyOwner(){
        
        kittyContract = KittyInterface(_adress);
    }
    
    function _triggerCoolDown(Zombie storage _zombie) internal{
        _zombie.readTime = uint32(now + coolDownTime);
    }
    
    function _isReady(Zombie storage _zombie) internal view returns(bool){
        return(_zombie.readyTime <= now);
    }
    
    function feedandMultiply(uint _zombieId, uint _targetDna, string memory _species) internal{
        
        require(msg.sender == zombieToOwner[_zombieId]);
        Zombie storage myZombie = zombies[_zombieId];
        require(_isReady(myZombie));
        _targetDna = _targetDna % dnaModula;
        uint newDna =( _targetDna + myZombie.Dna) /2;
        
        if(keccak256(abi.encodePacked(_species)) == keccak256(abi.encodePacked("kitty"))){
            
            
        }
        _createZombie("Noname", newDna);
        _triggerCoolDown(myZombie);
    }
    
    function feeOnKitty(uint _zombieId, uint kittyId) public{
        
        uint kittyDna;
        (,,,,,,,,,kittyDna) = kittyContract.getKitty(_kittyId);
        feedandMultiply(_zombieId, kittyDna, "kitty");
    }
}