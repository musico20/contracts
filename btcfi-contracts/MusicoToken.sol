// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MusicoToken is ERC20 {
    address public owner;

    constructor() ERC20("MusicoToken", "MUSI") {
        owner = msg.sender;
        _mint(msg.sender, 1000000 * 10 ** decimals()); // Initial supply
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Caller is not the owner");
        _;
    }

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    function burn(address from, uint256 amount) public onlyOwner {
        _burn(from, amount);
    }
}
