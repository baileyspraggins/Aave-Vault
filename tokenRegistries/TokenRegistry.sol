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


    /* Mainnet */
    Token public lusd = Token({
        shareName: "Wrapped aLUSD",
        shareSymbol: "waLUSD",
        shareDecimals: 18,
        underlyingAddress: 0x5f98805A4E8be255a32880FDeC7F6728C6568bA0,
        initialDeposit: 50e18
    });

    /* Sepolia Testnet Deployments */
    Token public sepoliaDAI = Token({
        shareName: "Wrapped aDAI",
        shareSymbol: "waDAI",
        shareDecimals: 18,
        underlyingAddress: 0x68194a729C2450ad26072b3D33ADaCbcef39D574,
        initialDeposit: 50e18
    });

    function _setState(uint256 chainId) internal {
        if (chainId == 1) {
            // Mainnet
            lendingPool = 0x87870Bca3F3fD6335C3F4ce8392D69350B4fA4E2;
            poolAddressProvider = 0x2f39d218133AFaB8F2B819B1066c7E434Ad94E9e;
            tokens.push(lusd);
        } else if (chainId == 11155111) {
            // Fuji Testnet
            lendingPool = 0xE7EC1B0015eb2ADEedb1B7f9F1Ce82F9DAD6dF08;
            poolAddressProvider = 0x0496275d34753A48320CA58103d5220d394FF77F;
            tokens.push(sepoliaDAI);
        } else {
            revert("Invalid Chain Id");
        }
    }
}