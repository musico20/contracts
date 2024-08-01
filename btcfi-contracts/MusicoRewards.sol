// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract MusicoRewards {
    IERC20 public musicoToken;
    address public owner;

    struct Creator {
        uint256 totalEarnings;
    }

    struct Listener {
        uint256 totalRewards;
    }

    mapping(address => Creator) public creators;
    mapping(address => Listener) public listeners;

    modifier onlyOwner() {
        require(msg.sender == owner, "Caller is not the owner");
        _;
    }

    event RewardPaid(address indexed listener, uint256 reward);
    event CreatorPaid(address indexed creator, uint256 amount);

    constructor(address _musicoToken) {
        musicoToken = IERC20(_musicoToken);
        owner = msg.sender;
    }

    function rewardListener(address listener, uint256 amount) public onlyOwner {
        require(musicoToken.balanceOf(address(this)) >= amount, "Insufficient funds");
        musicoToken.transfer(listener, amount);
        listeners[listener].totalRewards += amount;
        emit RewardPaid(listener, amount);
    }

    function payCreator(address creator, uint256 amount) public onlyOwner {
        require(musicoToken.balanceOf(address(this)) >= amount, "Insufficient funds");
        musicoToken.transfer(creator, amount);
        creators[creator].totalEarnings += amount;
        emit CreatorPaid(creator, amount);
    }

    function depositTokens(uint256 amount) public onlyOwner {
        musicoToken.transferFrom(msg.sender, address(this), amount);
    }
}
