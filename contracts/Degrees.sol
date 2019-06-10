pragma solidity ^0.5.0;

contract Degrees {
    address private owner;
    uint private k;// the required amount of signatures to be considered a graduate

    // the string will be the hash of the graduates info
    mapping(string => Professor[]) public graduates;
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
        require(msg.sender == owner, "You are not the contract's owner");
        _;
    }

    modifier isProf() {
        bool b = false;
        address s = msg.sender;

        for(uint8 i = 0; i<professors.length; i++){
            if(professors[i].profAddress == s){
                b = true;
            }
        }

        require(b,"Not a Professor");
        _;
    }

    constructor() public {
        owner = msg.sender;
        addProf(address(0x000001),"mf");
        addProf(address(0x000002),"kanatas");
    }

    // this function must only be called at the contract's creation
    function addProf(address _profAddress, string memory _name) private isOwner{
        Professor memory p = Professor({
            profAddress: _profAddress,
            name: _name,
            id: professors.length
        });

        professors.push(p);

        emit newProfessorRegistered(p.id);
    }

    function verifyGraduation(string memory _hash) public returns(bool){
        Professor[] memory approvals = graduates[_hash];
        if(approvals.length >= k){
            return true;
        }
        return false;
    }

    function signGraduation(string memory hash) public isProf{
        int index = getProfessorIndex();
        require(index>=0,"Only Professors can sign graduations");
        graduates[hash].push(professors[uint(index)]);
    }

    function getProfessorIndex() public isProf returns(int){
        for(uint i = 0; i<professors.length; i++){
            if(professors[i].profAddress == msg.sender){
                return int(i);
            }
        }
        return -1;
    }
}