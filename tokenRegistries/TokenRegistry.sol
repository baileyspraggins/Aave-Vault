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


    /* Avalanche C-Chain deplpoyments */
    Token public frax = Token({
        shareName: "Wrapped aFRAX",
        shareSymbol: "waFRAX",
        shareDecimals: 18,
        underlyingAddress: 0xD24C2Ad096400B6FBcd2ad8B24E7acBc21A1da64,
        initialDeposit: 50e18
    });

    Token public usdc = Token({
        shareName: "Wrapped aUSDC",
        shareSymbol: "waUSDC",
        shareDecimals: 6,
        underlyingAddress: 0xB97EF9Ef8734C71904D8002F8b6Bc66Dd9c48a6E,
        initialDeposit: 50e6
    });

    Token public usdt = Token({
        shareName: "Wrapped aUSDT",
        shareSymbol: "waUSDT",
        shareDecimals: 6,
        underlyingAddress: 0x9702230A8Ea53601f5cD2dc00fDBc13d4dF4A8c7,
        initialDeposit: 50e6
    });

    Token public btcB = Token({
        shareName: "Wrapped aBTC.b",
        shareSymbol: "waBTC.b",
        shareDecimals: 8,
        underlyingAddress: 0x152b9d0FdC40C096757F570A51E494bd4b943E50,
        initialDeposit: 3e4
    });

    Token public wavax = Token({
        shareName: "Wrapped aWAVAX",
        shareSymbol: "waWAVAX",
        shareDecimals: 18,
        underlyingAddress: 0xB31f66AA3C1e785363F0875A1B74E27b85FD66c7,
        initialDeposit: 5e18
    });

    /* Fuji Testnet Deployments */
    Token public fujiUsdc = Token({
        shareName: "Wrapped aUSDC",
        shareSymbol: "waUSDC",
        shareDecimals: 6,
        underlyingAddress: 0x6a17716Ce178e84835cfA73AbdB71cb455032456,
        initialDeposit: 50e6
    });

    Token public fujiUsdt = Token({
        shareName: "Wrapped aUSDT",
        shareSymbol: "waUSDT",
        shareDecimals: 6,
        underlyingAddress: 0x0343A9099f42868C1E8Ae9e501Abc043FD5fD816,
        initialDeposit: 50e6
    });

    function _setState(uint256 chainId) internal {
        if (chainId == 43114) {
            // Avalanche C-Chain
            lendingPool = 0x794a61358D6845594F94dc1DB02A252b5b4814aD;
            poolAddressProvider = 0xa97684ead0e402dC232d5A977953DF7ECBaB3CDb;
            tokens.push(frax);
            tokens.push(usdc);
            tokens.push(usdt);
            tokens.push(btcB);
            tokens.push(wavax);
        } else if (chainId == 43113) {
            // Fuji Testnet
            lendingPool = 0xf319Bb55994dD1211bC34A7A26A336C6DD0B1b00;
            poolAddressProvider = 0x220c6A7D868FC38ECB47d5E69b99e9906300286A;
            tokens.push(fujiUsdc);
            tokens.push(fujiUsdt);
        } else {
            revert("Invalid Chain Id");
        }
    }
}