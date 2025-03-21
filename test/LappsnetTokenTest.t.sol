// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Test} from "forge-std/Test.sol";
import {DeployLappsnetToken} from "../script/DeployLappsnetToken.s.sol";
import {LappsnetToken} from "../src/LappsnetToken.sol";

contract LappsnetTokenTest is Test {
    LappsnetToken public lappsnetToken;
    DeployLappsnetToken public deployer;

    address bob = makeAddr("bob");
    address alice = makeAddr("alice");

    uint256 public constant STARTING_BALANCE = 100 ether;

    function setUp() public {
        deployer = new DeployLappsnetToken();
        lappsnetToken = deployer.run();

        // Tokens are minted to the test contract (msg.sender),
        // so transfer from msg.sender (the test contract) to Bob.
        lappsnetToken.transfer(bob, STARTING_BALANCE);
    }

    function testBobbalance() public {
        // Bob should now have the STARTING_BALANCE tokens.
        assertEq(lappsnetToken.balanceOf(bob), STARTING_BALANCE);
    }

    function testAllowanceWorks() public {
        uint256 initialAllowance = 100 ether;
        uint256 transferAmount = 50 ether;

        // Bob approves Alice to spend tokens on his behalf.
        vm.prank(bob);
        lappsnetToken.approve(alice, initialAllowance);

        // Now Alice transfers part of Bob's tokens to herself.
        vm.prank(alice);
        lappsnetToken.transferFrom(bob, alice, transferAmount);

        // Check that Alice received the correct amount.
        assertEq(lappsnetToken.balanceOf(alice), transferAmount);
        // And Bob's remaining balance is reduced accordingly.
        assertEq(lappsnetToken.balanceOf(bob), STARTING_BALANCE - transferAmount);
    }
}
