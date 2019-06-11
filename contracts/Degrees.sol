pragma solidity ^0.5.5;

contract Degrees {
    address private owner;
    uint private k = 2;// the required amount of signatures to be considered a graduate

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

    event profAttemptedToSignMoreThanOnce(
        string _name
        );

    // indexed allows a student to filter events to a certain hash (his own)
    event newGraduateSignature(
        string indexed _hash,
        string _name
        );

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

    constructor() public{
        owner = msg.sender;
        addProf(address(0x4B0897b0513fdC7C541B6d9D7E929C4e5364D2dB),"mf");
        addProf(address(0x583031D1113aD414F02576BD6afaBfb302140225),"kanatas");
        addProf(address(0x14723A09ACff6D2A60DcdF7aA4AFf308FDDC160C),"xenakis");
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

    //In Solidity constant functions are functions, that are promised not to modify the state.
    //view can be considered as the subset of constant that will read the storage(hence viewing).
    //pure can be considered as the subset of constant where the return value will only be determined by it's parameters(input values) .
    function verifyGraduation(string memory _hash) public view returns(bool){
        Professor[] memory approvals = graduates[_hash];
        if(approvals.length >= k){
            return true;
        }
        return false;
    }

    //external functions can only be called outside the contract
    function signGraduation(string calldata hash) external isProf{
        int profIndex = getProfessorIndex();
        require(hasntAlreadySigned(profIndex,hash),"Professor attempted to sign more than once");
        require(profIndex>=0,"Only Professors can sign graduations");
        graduates[hash].push(professors[uint(profIndex)]);
        emit newGraduateSignature(hash,professors[uint(profIndex)].name);
    }

    function getProfessorIndex() public view isProf returns(int){
        for(uint i = 0; i<professors.length; i++){
            if(professors[i].profAddress == msg.sender){
                return int(i);
            }
        }
        return -1;
    }

    // public - all can access
    // external - Cannot be accessed internally, only externally
    // internal - only this contract and contracts deriving from it can access
    // private - can be accessed only from this contract
    function hasntAlreadySigned(int _profIndex, string memory _hash) internal view returns(bool){
        Professor memory prof = professors[uint(_profIndex)];
        Professor[] memory approvals = graduates[_hash];
        for(uint i = 0; i<approvals.length; i++){
            if(approvals[i].profAddress == prof.profAddress){
                // emit profAttemptedToSignMoreThanOnce(prof.name);
                return false;
            }
        }
        return true;
    }
}