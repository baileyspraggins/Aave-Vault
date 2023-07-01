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


    /* Polygon Mainnet deplpoyments */
    Token public mai = Token({
        shareName: "Wrapped aMAI",
        shareSymbol: "waMAI",
        shareDecimals: 18,
        underlyingAddress: ,
        initialDeposit: 50e18
    });

    /* Mumbai Testnet Deployments */
    Token public mumbaiDAI = Token({
        shareName: "Wrapped aDAI",
        shareSymbol: "waDAI",
        shareDecimals: 18,
        underlyingAddress: 0xF14f9596430931E177469715c591513308244e8F,
        initialDeposit: 50e18
    });

    function _setState(uint256 chainId) internal {
        if (chainId == 137) {
            // Polygon Mainnet
            lendingPool = 0x794a61358D6845594F94dc1DB02A252b5b4814aD;
            poolAddressProvider = 0xa97684ead0e402dC232d5A977953DF7ECBaB3CDb;
            tokens.push(frax);

        } else if (chainId == 80001) {
            // Mumbai Testnet
            lendingPool = 0x0b913A76beFF3887d35073b8e5530755D60F78C7;
            poolAddressProvider = 0xeb7A892BB04A8f836bDEeBbf60897A7Af1Bf5d7F;
            tokens.push(mumbaiDAI);
        } else {
            revert("Invalid Chain Id");
        }
    }
}