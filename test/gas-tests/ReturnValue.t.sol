// SPDX-License-Identifier: Apache-2.0
pragma solidity >=0.8.0 <0.9.0;

import { Test } from "forge-std/Test.sol";

// 12 007
contract FirstVersion {
    function doSomething(uint256 x, uint256 y, uint256 z) public pure returns (bytes32 hash) {
        // named return
        return keccak256(abi.encode(x, y, z)); // explicit return
    }
}

// 11 998
contract SecondVersion {
    function doSomething(uint256 x, uint256 y, uint256 z) public pure returns (bytes32 hash) {
        // named return
        hash = keccak256(abi.encode(x, y, z)); // no explicit return
    }
}

// 11 986
contract ThirdVersion {
    function doSomething(uint256 x, uint256 y, uint256 z) public pure returns (bytes32) {
        // no named return
        return keccak256(abi.encode(x, y, z)); // just return the value
    }
}

contract ReturnValueTest is Test {
    FirstVersion firstVersion;
    SecondVersion secondVersion;
    ThirdVersion thirdVersion;

    uint256 x = 100;
    uint256 y = 10 ** 21;
    uint256 z = 10 ** 44;

    function setUp() public {
        firstVersion = new FirstVersion();
        secondVersion = new SecondVersion();
        thirdVersion = new ThirdVersion();
    }

    function testFirstVersion() public view {
        firstVersion.doSomething(x, y, z);
    }

    function testSecondVersion() public view {
        secondVersion.doSomething(x, y, z);
    }

    function testThirdVersion() public view {
        thirdVersion.doSomething(x, y, z);
    }
}
