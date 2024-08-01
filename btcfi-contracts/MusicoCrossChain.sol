// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract MusicoCrossChain {
    IERC20 public musicoToken;
    address public owner;

    event CrossChainTransfer(address indexed from, address indexed to, uint256 amount, string targetChain);
    event CrossChainReceived(address indexed from, address indexed to, uint256 amount, string sourceChain);

    modifier onlyOwner() {
        require(msg.sender == owner, "Caller is not the owner");
        _;
    }

    constructor(address _musicoToken) {
        musicoToken = IERC20(_musicoToken);
        owner = msg.sender;
    }

    function crossChainTransfer(address to, uint256 amount, string memory targetChain) public {
        require(musicoToken.balanceOf(msg.sender) >= amount, "Insufficient balance");
        musicoToken.transferFrom(msg.sender, address(this), amount);
        emit CrossChainTransfer(msg.sender, to, amount, targetChain);
    }

    function crossChainReceive(address from, uint256 amount, string memory sourceChain) public onlyOwner {
        musicoToken.transfer(from, amount);
        emit CrossChainReceived(from, msg.sender, amount, sourceChain);
    }
}
