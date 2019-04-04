pragma solidity >=0.4.22 <0.6.0;

import "./CryptoConstellationBase.sol";
import "./ERC721.sol";
import "./ERC721Metadata.sol";



contract CryptoConstellationOwnership is CryptoConstellationBase, ERC721 {
    
    string public constant name = "CryptoConstellation";
    string public constant symbol = "CCL";

    ERC721Metadata public erc721Metadata;

    bytes4 constant InterfaceSignature_ERC165 =
        bytes4(keccak256('supportsInterface(bytes4)'));

    bytes4 constant InterfaceSignature_ERC721 =
        bytes4(keccak256('name()')) ^
        bytes4(keccak256('symbol()')) ^
        bytes4(keccak256('totalSupply()')) ^
        bytes4(keccak256('balanceOf(address)')) ^
        bytes4(keccak256('ownerOf(uint256)')) ^
        bytes4(keccak256('approve(address,uint256)')) ^
        bytes4(keccak256('transfer(address,uint256)')) ^
        bytes4(keccak256('transferFrom(address,address,uint256)')) ^
        bytes4(keccak256('tokensOfOwner(address)')) ^
        bytes4(keccak256('tokenMetadata(uint256,string)'));


    function supportsInterface(bytes4 _interfaceID) external view returns (bool)
    {
        
        return ((_interfaceID == InterfaceSignature_ERC165) || (_interfaceID == InterfaceSignature_ERC721));
    }

    function setMetadataAddress(address _contractAddress) public onlyCEO {
        erc721Metadata = ERC721Metadata(_contractAddress);
    }


    function _owns(address _claimant, uint256 _tokenId) internal view returns (bool) {
        return constellationCurrentOwner[_tokenId] == _claimant;
    }
    
    function _approvedFor(uint256 _tokenId) internal view returns (address) {
        return approvedOfConstellation[_tokenId];
    }

    function _approve(uint256 _tokenId, address _to) internal {
        require(msg.sender != _to);
        require(tokenExists(_tokenId));
        require(ownerOf(_tokenId) == msg.sender);

        if (_to == address(0)) {
            if (approvedOfConstellation[_tokenId] != address(0)) {
                delete approvedOfConstellation[_tokenId];
                emit Approval(msg.sender, address(0), _tokenId);
            }
        } else {
            approvedOfConstellation[_tokenId] = _to;
            emit Approval(msg.sender, _to, _tokenId);
        }
    }

    function ownerOf (uint256 _itemId) public view returns (address _owner) {
        return constellationCurrentOwner[_itemId];
    }

    function balanceOf(address _owner) public view returns (uint256 count) {
        return ownershipTokenCount[_owner];
    }

    function buy(uint256 _tokenId) payable external whenNotPaused 
    {
        require(priceOf(_tokenId) > 0);
        require(ownerOf(_tokenId) != address(0));
        require(msg.value >= priceOf(_tokenId));
        require(ownerOf(_tokenId) != msg.sender);
        require(msg.sender != address(0));

        address payable oldOwner = address(uint160(ownerOf(_tokenId)));
        address payable newOwner = msg.sender;
        uint256 price = priceOf(_tokenId);
        uint256 excess = msg.value.sub(price);

        _transfer(oldOwner, newOwner, _tokenId);
        priceOfConstellation[_tokenId] = nextPriceOf(_tokenId);

        emit Bought(_tokenId, newOwner, price);
        emit Sold(_tokenId, oldOwner, price);

        // Devevloper's cut which is left in contract and accesed by
        // `withdrawAll` and `withdrawAmountTo` methods.
        uint256 devCut = calculateDevCut(price);

        // Transfer payment to old owner minus the developer's cut.
        oldOwner.transfer(price.sub(devCut));

        if (excess > 0) {
            newOwner.transfer(excess);
        }
    }


    function approve(address _to, uint256 _tokenId) external whenNotPaused
    {
        require(_owns(msg.sender, _tokenId));
        
        _approve(_tokenId, _to);
    }

    function transfer(address _to, uint256 _itemId) external {
        require(msg.sender == ownerOf(_itemId));
        _transfer(msg.sender, _to, _itemId);
    }

    function transferFrom(address _from, address _to, uint256 _tokenId) external whenNotPaused
    {
        require(_to != address(0));
        require(_to != address(this));
        
        require(_approvedFor(_tokenId) == msg.sender);
        require(_owns(_from, _tokenId));


        _transfer(_from, _to, _tokenId);
    }
    
    

    function totalSupply() public view returns (uint) {
        return constellations.length - 1;
    }

    function tokenExists(uint256 _itemId) public view returns (bool _exists) {
    return priceOf(_itemId) > 0;
    }

    function startingPriceOf(uint256 _itemId) public view returns (uint256 _startingPrice) {
        return startingPriceOfConstellation[_itemId];
    }

    function priceOf(uint256 _itemId) public view returns (uint256 _price) {
        return priceOfConstellation[_itemId];
    }

    function nextPriceOf(uint256 _itemId) public view returns (uint256 _nextPrice) {
        return calculateNextPrice(priceOf(_itemId));
    }


    function tokensOfOwner(address _owner) external view returns(uint256[] memory ownerTokens) {
        uint256 tokenCount = balanceOf(_owner);

        if (tokenCount == 0) {
            // Return an empty array
            return new uint256[](0);
        } else {
            uint256[] memory result = new uint256[](tokenCount);
            uint256 totalConstellation = totalSupply();
            uint256 resultIndex = 0;

            uint256 constellationId;

            for (constellationId = 1; constellationId <= totalConstellation; constellationId++) {
                if (constellationCurrentOwner[constellationId] == _owner) {
                    result[resultIndex] = constellationId;
                    resultIndex++;
                }
            }

            return result;
        }
    }


    function _memcpy(uint _dest, uint _src, uint _len) private pure {
        // Copy word-length chunks while possible
        for(; _len >= 32; _len -= 32) {
            assembly {
                mstore(_dest, mload(_src))
            }
            _dest += 32;
            _src += 32;
        }

        // Copy remaining bytes
        uint256 mask = 256 ** (32 - _len) - 1;
        assembly {
            let srcpart := and(mload(_src), not(mask))
            let destpart := and(mload(_dest), mask)
            mstore(_dest, or(destpart, srcpart))
        }
    }
    
    
    function _toString(bytes32[4] memory _rawBytes, uint256 _stringLength) private pure returns (string memory) {
        string memory outputString = new string(_stringLength);
        uint256 outputPtr;
        uint256 bytesPtr;

        assembly {
            outputPtr := add(outputString, 32)
            bytesPtr := _rawBytes
        }

        _memcpy(outputPtr, bytesPtr, _stringLength);

        return outputString;
    }


    function tokenMetadata(uint256 _tokenId, string calldata _preferredTransport) external view returns (string memory infoUrl) {
        bytes32[4] memory buffer;
        uint256 count;
        (buffer, count) = erc721Metadata.getMetadata(_tokenId, _preferredTransport);

        return _toString(buffer, count);
    }

    function withdrawAll () onlyCLevel external {
        address payable companyAddress = address(uint160(ceoAddress));
        companyAddress.transfer(address(this).balance);
    }

    function withdrawAmount (uint256 _amount) onlyCLevel external {
        address payable companyAddress = address(uint160(ceoAddress));
        companyAddress.transfer(_amount);
    }
}