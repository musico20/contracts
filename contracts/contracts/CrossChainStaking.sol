// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

interface ZetaInterface {
    function stakeTokens(address token, uint256 amount, bytes calldata targetChain) external;
    function unstakeTokens(address token, uint256 amount, bytes calldata targetChain) external;
}

contract CrossChainStaking {
    IERC20 public stakingToken;
    ZetaInterface zeta;
    mapping(address => uint256) public stakes;

    constructor(address _stakingToken, address _zetaAddress) {
        stakingToken = IERC20(_stakingToken);
        zeta = ZetaInterface(_zetaAddress);
    }

    function stake(uint256 amount, bytes memory targetChain) public {
        stakingToken.transferFrom(msg.sender, address(this), amount);
        stakes[msg.sender] += amount;
        zeta.stakeTokens(address(stakingToken), amount, targetChain);
    }

    function withdrawStake(uint256 amount, bytes memory targetChain) public {
        require(stakes[msg.sender] >= amount, "Insufficient stake");
        stakes[msg.sender] -= amount;
        zeta.unstakeTokens(address(stakingToken), amount, targetChain);
        stakingToken.transfer(msg.sender, amount);
    }
}
