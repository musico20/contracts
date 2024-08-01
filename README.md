# Musico Decentralized Music Platform

## Overview

Musico is a decentralized music platform designed to reward both listeners and creators, allowing seamless interactions and transactions using the MusicoToken (MUSI). The platform incorporates multiple functionalities such as staking, liquidity pools, NFT minting for audio content, governance, and cross-chain capabilities.

## Features

### 1. MusicoToken (MUSI)
MusicoToken (MUSI) is the native ERC-20 token used for all transactions on the Musico platform.

- **Initial Supply**: 1,000,000 MUSI
- **Minting and Burning**: Tokens can be minted and burned by the contract owner.

### 2. MusicoRewards
The MusicoRewards contract handles rewarding listeners and creators based on their engagement and contributions.

- **Reward Listeners**: Automatically rewards listeners for playing audio content.
- **Pay Creators**: Pays creators based on the engagement their content receives.
- **Token Deposits**: Allows the owner to deposit tokens for rewards distribution.

### 3. MusicoLiquidityPool
The MusicoLiquidityPool contract manages staking and liquidity pools, allowing users to earn rewards based on their staked tokens.

- **Staking**: Users can stake their MUSI tokens.
- **Unstaking**: Users can unstake their tokens.
- **Rewards**: Distributes rewards based on the staked amount and engagement.

### 4. MusicoNFT
The MusicoNFT contract allows creators to mint their audio content as NFTs, providing new ways for content monetization.

- **Mint NFTs**: Creators can mint unique NFTs for their audio content.
- **Metadata**: Stores and manages metadata for each NFT.

### 5. MusicoGovernance
The MusicoGovernance contract enables decentralized governance, allowing token holders to propose and vote on changes to the platform.

- **Proposals**: Create and submit proposals.
- **Voting**: Vote on proposals using MUSI tokens.
- **Execution**: Execute successful proposals.

### 6. MusicoCrossChain
The MusicoCrossChain contract facilitates cross-chain transactions, enabling MUSI tokens to be transferred between Core DAO and BTCfi.

- **Cross-Chain Transfer**: Transfer MUSI tokens across different blockchains.
- **Cross-Chain Receive**: Receive MUSI tokens from other blockchains.
