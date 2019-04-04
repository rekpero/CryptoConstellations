pragma solidity >=0.4.22 <0.6.0;

import "./CryptoConstellationAccessControl.sol";
import "./SafeMath.sol";

contract CryptoConstellationBase is CryptoConstellationAccessControl {

    using SafeMath for uint256;
    
    event ConstellationCreation(address indexed _owner, uint256 indexed _tokenId);
    
    event Transfer(address indexed _from, address indexed _to, uint256 _tokenId);

    event Bought (uint256 indexed _tokenId, address indexed _owner, uint256 _price);

    event Sold (uint256 indexed _tokenId, address indexed _owner, uint256 _price);
    
    
    struct Constellation {
        string name;
        string description;
        string ipfsHash;
        uint64 creationTimestamp;
    }

    
    uint256 internal increaseLimit1 = 0.02 ether;
    uint256 internal increaseLimit2 = 0.5 ether;
    uint256 internal increaseLimit3 = 2.0 ether;
    uint256 internal increaseLimit4 = 5.0 ether;
    
    Constellation[] constellations;
    
    mapping (uint256 => address) public constellationCurrentOwner;
    
    mapping (address => uint256) internal ownershipTokenCount;

    mapping (uint256 => uint256) internal startingPriceOfConstellation;

    mapping (uint256 => uint256) internal priceOfConstellation;

    mapping (uint256 => address) internal approvedOfConstellation;
    
    
    modifier onlyOwner(uint _propId) {
		require(constellationCurrentOwner[_propId] == msg.sender);
		_;
	}

	
    
    function _transfer(address _from, address _to, uint256 _tokenId) internal {
        
        // Since the number of assets is capped to 2^32 we can't overflow this
        ownershipTokenCount[_to]++;
        // transfer ownership
        constellationCurrentOwner[_tokenId] = _to;

        approvedOfConstellation[_tokenId] = address(0);
        // When creating new kittens _from is 0x0, but we can't account that address.
        if (_from != address(0)) {
            ownershipTokenCount[_from]--;
        }
        // Emit the transfer event.
        emit Transfer(_from, _to, _tokenId);
    }
    
    
    function calculateNextPrice (uint256 _price) public view returns (uint256 _nextPrice) {
        if (_price < increaseLimit1) {
            return _price.mul(200).div(95);
        } else if (_price < increaseLimit2) {
            return _price.mul(135).div(96);
        } else if (_price < increaseLimit3) {
            return _price.mul(125).div(97);
        } else if (_price < increaseLimit4) {
            return _price.mul(117).div(97);
        } else {
            return _price.mul(115).div(98);
        }
    }

    function calculateDevCut (uint256 _price) public view returns (uint256 _devCut) {
        if (_price < increaseLimit1) {
            return _price.mul(10).div(100); // 10%
        } else if (_price < increaseLimit2) {
            return _price.mul(9).div(100); // 9%
        } else if (_price < increaseLimit3) {
            return _price.mul(8).div(100); // 8%
        } else if (_price < increaseLimit4) {
            return _price.mul(7).div(100); // 7%
        } else {
            return _price.mul(6).div(100); // 6%
        }
    }

    
    function createConstellation(
        string calldata _name,
        string calldata _description,
        string calldata _ipfsHash,
        uint256 _price,
        address _owner
    )
        external
        whenNotPaused
        onlyCLevel
        returns (uint)
    {
        return _createConstellation(_name, _description, _ipfsHash, _price, _owner);
    }
    
    function _createConstellation(
        string memory _name,
        string memory _description,
        string memory _ipfsHash,
        uint256 _price,
        address _owner
    )
        internal
        whenNotPaused
        onlyCLevel
        returns (uint)
    {
        
        Constellation memory _constellation = Constellation({
            name: _name,
            description: _description,
            ipfsHash: _ipfsHash,
            creationTimestamp: uint64(block.timestamp)
        });
        uint256 newConstellationId = constellations.push(_constellation) - 1;

        require(newConstellationId == uint256(uint32(newConstellationId)));

        startingPriceOfConstellation[newConstellationId] = _price;
        priceOfConstellation[newConstellationId] = _price;


        // emit the birth event
        emit ConstellationCreation(_owner, newConstellationId);

        _transfer(address(0), _owner, newConstellationId);

        return newConstellationId;
    }
    
    
    
    
}