// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface ZetaInterface {
    function callContract(bytes calldata targetChain, bytes calldata data) external;
}

contract CrossChainSmartContract {
    ZetaInterface zeta;

    constructor(address _zetaAddress) {
        zeta = ZetaInterface(_zetaAddress);
    }

    function interactAcrossChains(bytes memory targetChain, bytes memory data) public {
        zeta.callContract(targetChain, data);
    }
}
