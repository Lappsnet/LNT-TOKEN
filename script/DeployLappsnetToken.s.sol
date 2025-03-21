// script/DeployLappsnetToken.s.sol
//SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {LappsnetToken} from "../src/LappsnetToken.sol";

contract DeployLappsnetToken is Script {
    uint256 public constant INITIAL_SUPPLY = 100 ether;

    function run() external returns (LappsnetToken){
        vm.startBroadcast();
        LappsnetToken lappsnettoken = new LappsnetToken();
        vm.stopBroadcast();
        return lappsnettoken;
    }
}