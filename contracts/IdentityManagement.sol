// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract IdentityManagement {
    mapping(address => string) public identities;

    function setIdentity(string memory identity) public {
        identities[msg.sender] = identity;
    }

    function getIdentity(address user) public view returns (string memory) {
        return identities[user];
    }
}
