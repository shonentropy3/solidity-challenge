// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts-upgradeable/utils/cryptography/ECDSAUpgradeable.sol";
//import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "./AdminRole.sol";

contract SignMessage is AdminRoleUpgrade {
    using ECDSAUpgradeable for bytes32;

    address public signerAddress;
    mapping(address => uint256) public nonce;

    constructor() {
        _addAdmin(msg.sender);

        signerAddress = 0xa1f016Da2B99fE11565230B7e5273496C5236A12;
    }


    function verifySig(
        address sender,
        bytes calldata signature
    ) external  returns(bool)  {
        bytes32 messageHash = keccak256(
            abi.encodePacked(sender, nonce[sender])
        );
        nonce[sender]++;
        return
            signerAddress ==
            messageHash.toEthSignedMessageHash().recover(signature);
    }

    function REverifySig(
        address sender,
        bytes calldata signature
    ) external  view returns(address)  {
        bytes32 messageHash = keccak256(
            abi.encodePacked(sender, nonce[sender])
        );
      
        return
            
            messageHash.toEthSignedMessageHash().recover(signature);
    }


}