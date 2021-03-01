    pragma solidity 0.5.1;

contract MyContract{
    //enums
    enum State {Waiting, Ready, Active}
    State public state;
    
    constructor() public{
        state = State.Waiting;
    }
    
    function activates() public{
        state = State.Active;
    }
    function deactivates() public{
        state = State.Waiting;
    }
    
    function isActive() public view returns(bool){
        return state == State.Active;
    }

//structs
    Person[] public people;
    uint256 public countPeople;
    struct Person{
        string _firstName;
        string _lastName;
    }
    
    function addperson(string memory _firstName, string memory _lastName) public{
        people.push(Person(_firstName, _lastName));
        countPeople ++;
    }
//using mappings instead
    uint256 public countPeople = 0;
    mapping(uint => Person) public people;
    
    struct Person{
        uint _id;
        string _firstName;
        string _lastName;
    }
    
    function addperson(string memory _firstName, string memory _lastName) public{
        countPeople ++;
       people[countPeople] = Person(countPeople, _firstName, _lastName);
        
    }

    //modifiers and internals
     uint256 public countPeople = 0;
    mapping(uint => Person) public people;
    address owner;
    
    modifier onlyOwner(){
        require(msg.sender == owner);
        _;
    }
    struct Person{
        uint _id;
        string _firstName;
        string _lastName;
    }
    
    constructor() public {
        owner == msg.sender;
    }
    
    function addperson(string memory _firstName, string memory _lastName) public onlyOwner {
        incrementCount();
       people[countPeople] = Person(countPeople, _firstName, _lastName);
        
    }
    function incrementCount() internal{
        countPeople ++;
    }
}



