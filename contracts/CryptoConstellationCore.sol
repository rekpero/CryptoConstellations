pragma solidity >=0.4.22 <0.6.0;

import "./CryptoConstellationOwnership.sol";

contract CryptoConstellationCore is CryptoConstellationOwnership{
    
    
    
    constructor() public{

        // the creator of the contract is the initial CEO
        ceoAddress = msg.sender;

        // the creator of the contract is also the initial CTO
        ctoAddress = msg.sender;

    }
    
    
    /*function() external payable {
        require(
            msg.sender == address(saleAuction) ||
            msg.sender == address(siringAuction)
        );
    }*/
    
    function getConstellation(uint256 _id)
        external
        view
        returns (
        string memory _name,
        string memory _description,
        string memory _ipfsHash,
        address _owner, 
        uint256 _startingPrice, 
        uint256 _price, 
        uint256 _nextPrice
    ) {
        Constellation memory constellation = constellations[_id];
        
        _name = constellation.name;
        _description = constellation.description;
        _ipfsHash = constellation.ipfsHash;
        _owner = ownerOf(_id);
        _startingPrice = startingPriceOf(_id);
        _price = priceOf(_id);
        _nextPrice = nextPriceOf(_id);
        
    }
    
    
}