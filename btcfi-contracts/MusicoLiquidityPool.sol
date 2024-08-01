// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract MusicoLiquidityPool {
    IERC20 public musicoToken;
    address public owner;

    struct Staker {
        uint256 amount;
        uint256 rewardDebt;
    }

    mapping(address => Staker) public stakers;
    uint256 public totalStaked;
    uint256 public accTokenPerShare;
    uint256 public lastRewardTime;
    uint256 public rewardRate;

    modifier onlyOwner() {
        require(msg.sender == owner, "Caller is not the owner");
        _;
    }

    event Stake(address indexed user, uint256 amount);
    event Unstake(address indexed user, uint256 amount);
    event ClaimReward(address indexed user, uint256 reward);

    constructor(address _musicoToken, uint256 _rewardRate) {
        musicoToken = IERC20(_musicoToken);
        rewardRate = _rewardRate;
        owner = msg.sender;
        lastRewardTime = block.timestamp;
    }

    function stake(uint256 amount) public {
        updatePool();
        if (stakers[msg.sender].amount > 0) {
            uint256 pending = stakers[msg.sender].amount * accTokenPerShare / 1e12 - stakers[msg.sender].rewardDebt;
            if (pending > 0) {
                musicoToken.transfer(msg.sender, pending);
                emit ClaimReward(msg.sender, pending);
            }
        }
        musicoToken.transferFrom(msg.sender, address(this), amount);
        stakers[msg.sender].amount += amount;
        stakers[msg.sender].rewardDebt = stakers[msg.sender].amount * accTokenPerShare / 1e12;
        totalStaked += amount;
        emit Stake(msg.sender, amount);
    }

    function unstake(uint256 amount) public {
        require(stakers[msg.sender].amount >= amount, "Insufficient staked amount");
        updatePool();
        uint256 pending = stakers[msg.sender].amount * accTokenPerShare / 1e12 - stakers[msg.sender].rewardDebt;
        if (pending > 0) {
            musicoToken.transfer(msg.sender, pending);
            emit ClaimReward(msg.sender, pending);
        }
        musicoToken.transfer(msg.sender, amount);
        stakers[msg.sender].amount -= amount;
        stakers[msg.sender].rewardDebt = stakers[msg.sender].amount * accTokenPerShare / 1e12;
        totalStaked -= amount;
        emit Unstake(msg.sender, amount);
    }

    function updatePool() internal {
        if (block.timestamp <= lastRewardTime) {
            return;
        }
        if (totalStaked == 0) {
            lastRewardTime = block.timestamp;
            return;
        }
        uint256 reward = (block.timestamp - lastRewardTime) * rewardRate;
        accTokenPerShare += reward * 1e12 / totalStaked;
        lastRewardTime = block.timestamp;
    }

    function pendingReward(address user) external view returns (uint256) {
        Staker storage staker = stakers[user];
        uint256 _accTokenPerShare = accTokenPerShare;
        if (block.timestamp > lastRewardTime && totalStaked != 0) {
            uint256 reward = (block.timestamp - lastRewardTime) * rewardRate;
            _accTokenPerShare += reward * 1e12 / totalStaked;
        }
        return staker.amount * _accTokenPerShare / 1e12 - staker.rewardDebt;
    }
}
