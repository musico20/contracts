// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract MusicoGovernance {
    IERC20 public musicoToken;
    address public owner;
    uint256 public proposalCount;
    uint256 public votingPeriod;

    struct Proposal {
        uint256 id;
        address proposer;
        string description;
        uint256 votesFor;
        uint256 votesAgainst;
        uint256 startTime;
        bool executed;
    }

    mapping(uint256 => Proposal) public proposals;
    mapping(uint256 => mapping(address => bool)) public votes;

    modifier onlyOwner() {
        require(msg.sender == owner, "Caller is not the owner");
        _;
    }

    event ProposalCreated(uint256 id, address proposer, string description);
    event VoteCasted(uint256 id, address voter, bool support);
    event ProposalExecuted(uint256 id, bool success);

    constructor(address _musicoToken, uint256 _votingPeriod) {
        musicoToken = IERC20(_musicoToken);
        owner = msg.sender;
        votingPeriod = _votingPeriod;
    }

    function createProposal(string memory description) public {
        proposals[proposalCount] = Proposal({
            id: proposalCount,
            proposer: msg.sender,
            description: description,
            votesFor: 0,
            votesAgainst: 0,
            startTime: block.timestamp,
            executed: false
        });
        emit ProposalCreated(proposalCount, msg.sender, description);
        proposalCount++;
    }

    function vote(uint256 id, bool support) public {
        require(proposals[id].startTime > 0, "Proposal does not exist");
        require(block.timestamp < proposals[id].startTime + votingPeriod, "Voting period has ended");
        require(!votes[id][msg.sender], "Already voted");

        if (support) {
            proposals[id].votesFor += musicoToken.balanceOf(msg.sender);
        } else {
            proposals[id].votesAgainst += musicoToken.balanceOf(msg.sender);
        }
        votes[id][msg.sender] = true;
        emit VoteCasted(id, msg.sender, support);
    }

    function executeProposal(uint256 id) public onlyOwner {
        Proposal storage proposal = proposals[id];
        require(proposal.startTime > 0, "Proposal does not exist");
        require(block.timestamp >= proposal.startTime + votingPeriod, "Voting period not ended");
        require(!proposal.executed, "Proposal already executed");

        if (proposal.votesFor > proposal.votesAgainst) {
            proposal.executed = true;
            emit ProposalExecuted(id, true);
        } else {
            proposal.executed = true;
            emit ProposalExecuted(id, false);
        }
    }

    function setVotingPeriod(uint256 _votingPeriod) public onlyOwner {
        votingPeriod = _votingPeriod;
    }
}
