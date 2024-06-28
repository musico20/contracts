// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

interface ZetaInterface {
    function sendNFT(address nft, address to, uint256 tokenId, bytes calldata targetChain) external;
}

contract InteroperableNFT is ERC721 {
    ZetaInterface zeta;

    constructor(address _zetaAddress) ERC721("InteroperableNFT", "iNFT") {
        zeta = ZetaInterface(_zetaAddress);
    }

    function mintNFT(address to, uint256 tokenId) public {
        _mint(to, tokenId);
    }

    function transferCrossChain(address to, uint256 tokenId, bytes memory targetChain) public {
        transferFrom(msg.sender, address(this), tokenId);
        zeta.sendNFT(address(this), to, tokenId, targetChain);
    }
}
