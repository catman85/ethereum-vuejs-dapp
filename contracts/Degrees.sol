pragma solidity ^0.5.0;

contract Degrees {
    address private owner;
    mapping(string => bool) public graduates;
    // mapping(address => Professor) public professors;

    Professor[] public professors;

    struct Professor {
        address profAddress;
        string name;
        uint id;
    }

    event newProfessorRegistered(uint id);

    // _; tells us where the body of the caller function will be injected
    modifier isOwner() {
        require(msg.sender == owner);
        _;
    }

    modifier isProf() {
        bool b = false;
        address s = msg.sender;

        for(uint8 i=0; i<professors.length; i++){
            if(professors[i].profAddress == s){
                b=true;
            }
        }

        require(b);
        _;
    }

    constructor() public {
        owner = msg.sender;
        addProf(address(0x000001),"mf");
        addProf(address(0x000002),"kanatas");
    }

    // this function must only be called at the contract's creation
    function addProf(address _profAddress, string memory _name) isOwner private {
        Professor memory p = Professor({
            profAddress: _profAddress,
            name: _name,
            id: professors.length
        });

        professors.push(p);

        emit newProfessorRegistered(p.id);
    }
}