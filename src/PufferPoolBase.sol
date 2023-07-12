// SPDX-License-Identifier: Apache-2.0
pragma solidity >=0.8.0 <0.9.0;

import { IPufferPool } from "puffer/interface/IPufferPool.sol";

abstract contract PufferPoolBase is IPufferPool {
    // Pool parameters
    bytes32 CREW_MRENCLAVE;
    uint256 remoteAttestationFreshnessThreshold;
    uint256 crewSize;
    uint256 crewThreshold;
    uint256 crewKeyRotationInterval;

    // Pool state
    struct Pod {
        address account;
    }

    mapping(bytes32 => mapping(address => Pod)) public pods;

    function extractEnclaveEthKeys(bytes[] memory payloads) internal virtual returns (bytes[] memory pubKeys);

    function decodeToEthPubkey(bytes memory enclavePayload) internal pure virtual returns (bytes memory pubKey);

    function crewAccountFactory(bytes[] memory crewEnclavePubKeys, address[] memory crewWallets, bytes32 mrenclave)
        internal
        virtual
        returns (address accountAddress);

    function podAccountFactory(bytes[] memory podEnclavePubKeys, address[] memory podWallets, bytes32 mrenclave)
        internal
        virtual
        returns (address accountAddress);

    function splitterContractFactory(bytes32 seed) internal virtual returns (address contractAddress);

    /**
     * @dev This empty reserved space is put in place to allow future versions to add new
     * variables without shifting down storage in the inheritance chain.
     * See https://docs.openzeppelin.com/contracts/4.x/upgradeable#storage_gaps
     */
    uint256[50] private __gap;
}
