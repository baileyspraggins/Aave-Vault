// SPDX-License-Identifier: MIT

pragma solidity ^0.8.10;

contract TokenRegistry {
    struct Token {
        string shareName;
        string shareSymbol;
        uint256 shareDecimals;
        address underlyingAddress;
        uint256 initialDeposit;
    }

    address lendingPool = address(0);
    address poolAddressProvider = address(0);
    Token[] tokens;

    // TODO: ASK about compatability
    /* Arbitrum Mainnet Deployments */
    Token public arb = Token({
        shareName: "Wrapped aARB",
        shareSymbol: "waARB",
        shareDecimals: 18,
        underlyingAddress: 0x912CE59144191C1204E64559FE8253a0e49E6548,
        initialDeposit: 50e18
    });

    Token public usdc = Token({
        shareName: "Wrapped aUSDC",
        shareSymbol: "waUSDC",
        shareDecimals: 6,
        underlyingAddress: 0xFF970A61A04b1cA14834A43f5dE4533eBDDB5CC8,
        initialDeposit: 50e6
    });

    function _setState(uint256 chainId) internal {
        if (chainId == 42161) {
            // Arbitrum
            lendingPool = 0x794a61358D6845594F94dc1DB02A252b5b4814aD;
            poolAddressProvider = 0x770ef9f4fe897e59daCc474EF11238303F9552b6;
            tokens.push(arb);
            tokens.push(usdc);
        } else {
            revert("Invalid Chain Id");
        }
    }
}