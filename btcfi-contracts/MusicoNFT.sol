// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract MusicoNFT is ERC721 {
    address public owner;
    uint256 public nextTokenId;
    mapping(uint256 => string) private _tokenURIs;

    event Minted(address indexed creator, uint256 indexed tokenId, string tokenURI);

    modifier onlyOwner() {
        require(msg.sender == owner, "Caller is not the owner");
        _;
    }

    constructor() ERC721("MusicoNFT", "MUSINFT") {
        owner = msg.sender;
    }

    function mint(address to, string memory tokenURI) public onlyOwner {
        uint256 tokenId = nextTokenId++;
        _mint(to, tokenId);
        _setTokenURI(tokenId, tokenURI);
        emit Minted(to, tokenId, tokenURI);
    }

    function _setTokenURI(uint256 tokenId, string memory tokenURI) internal {
        _tokenURIs[tokenId] = tokenURI;
    }

    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        return _tokenURIs[tokenId];
    }
}
