// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

interface ZetaInterface {
    function sendToken(address token, address to, uint256 amount, bytes calldata targetChain) external;
    function sendNFT(address nft, address to, uint256 tokenId, bytes calldata targetChain) external;
}

contract CrossChainAssetTransfer {
    ZetaInterface zeta;

    constructor(address _zetaAddress) {
        zeta = ZetaInterface(_zetaAddress);
    }

    function transferToken(address token, address to, uint256 amount, bytes memory targetChain) public {
        IERC20(token).transferFrom(msg.sender, address(this), amount);
        zeta.sendToken(token, to, amount, targetChain);
    }

    function transferNFT(address nft, address to, uint256 tokenId, bytes memory targetChain) public {
        IERC721(nft).transferFrom(msg.sender, address(this), tokenId);
        zeta.sendNFT(nft, to, tokenId, targetChain);
    }
}
