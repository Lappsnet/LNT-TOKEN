// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract LappsnetToken is ERC20 {
    constructor() ERC20("LappsnetToken", "LPT") {
        _mint(msg.sender, 100 ether);
    }
}
