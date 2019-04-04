pragma solidity >=0.4.22 <0.6.0;


contract CryptoConstellationAccessControl  {
    
    address public ceoAddress;
    address public ctoAddress;
    address public cfoAddress;
    address public cooAddress;

    bool public paused = false;
    
    mapping (address => string) public userNickName;

    modifier onlyCEO() {
        require(msg.sender == ceoAddress);
        _;
    }
    
    modifier onlyCTO() {
        require(msg.sender == ctoAddress);
        _;
    }

    modifier onlyCFO() {
        require(msg.sender == cfoAddress);
        _;
    }

    modifier onlyCOO() {
        require(msg.sender == cooAddress);
        _;
    }

    modifier onlyCLevel() {
        require(
            msg.sender == cooAddress ||
            msg.sender == ceoAddress ||
            msg.sender == cfoAddress ||
            msg.sender == ctoAddress
        );
        _;
    }
    



    function setCEO(address _newCEO) external onlyCEO {
        require(_newCEO != address(0));

        ceoAddress = _newCEO;
    }
    
    function setCTO(address _newCTO) external onlyCEO {
        require(_newCTO != address(0));

        ctoAddress = _newCTO;
    }

    function setCFO(address _newCFO) external onlyCEO {
        require(_newCFO != address(0));
        
        cfoAddress = _newCFO;
    }

    function setCOO(address _newCOO) external onlyCEO {
        require(_newCOO != address(0));

        cooAddress = _newCOO;
    }

    function setNickName(address _user, string calldata _nickName) external returns (bool) {
        require(_user != address(0));

        userNickName[_user] = _nickName;
    }

    modifier whenNotPaused() {
        require(!paused);
        _;
    }

    modifier whenPaused {
        require(paused);
        _;
    }


    function pause() external onlyCLevel whenNotPaused {
        paused = true;
    }
    
    function unpause() external onlyCEO whenPaused {
        // can't unpause if contract was upgraded
        paused = false;
    }

    
    
    
}