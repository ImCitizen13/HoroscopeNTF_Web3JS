//SPDX-License-Identifier:UNLICENCED
pragma solidity ^0.8.9;

import "hardhat/console.sol";

contract Greeter {
    string private greeting;

    constructor(string memory _greeting) {
        console.log("Deploying a Greeter with greeting:", _greeting);
        greeting = _greeting;
    }

    // Getter
    function greet() public view returns (string memory) {
        return greeting;
    }

    // Setter
    function setGreeting(string memory _greeting) public {
        console.log("Changing greeting from '%s' to '%s'", greeting, _greeting);
        greeting = _greeting;
    }
}
