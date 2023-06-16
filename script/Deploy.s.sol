// SPDX-License-Identifier: MIT

pragma solidity ^0.8.10;

import "forge-std/Script.sol";
import {TransparentUpgradeableProxy} from "@openzeppelin/proxy/transparent/TransparentUpgradeableProxy.sol";
import {IERC20Upgradeable} from "@openzeppelin-upgradeable/interfaces/IERC20Upgradeable.sol";

import { TokenRegistry } from "../tokenRegistries/TokenRegistry.sol";

import "../src/ATokenVault.sol";

contract Deploy is Script, TokenRegistry {


    // DEPLOYMENT PARAMETERS - CHANGE THESE FOR YOUR VAULT
    // ===================================================
    // TODO: Replace with correct addresses
    address proxyAdmin = 0x326A7778DB9B741Cb2acA0DE07b9402C7685dAc6;
    address owner = 0x326A7778DB9B741Cb2acA0DE07b9402C7685dAc6;
    uint256 fee = 0;
    uint16 referralCode = 2977;
    // ===================================================
    ATokenVault public vault;
    TokenRegistry registry = new TokenRegistry();
    function getChainId() public view returns (uint256) {
        uint256 chainId;
        assembly {
            chainId := chainid()
        }
        return chainId;
    }

    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");

        address deployerAddress = vm.addr(deployerPrivateKey);
        console.log("Deployer address: ", deployerAddress);
        console.log("Deployer balance: ", deployerAddress.balance);
        console.log("BlockNumber: ", block.number);
        console.log("ChainId: ", getChainId());
        console.log("Deploying vault...");
        
        // Initialize state variables
        _setState(getChainId());
        // Check balances to make sure we have enough to deploy
        for (uint256 i = 0; i < tokens.length; i++) {
            require(

                tokens[i].initialDeposit != 0,
                "Initial deposit not set. This prevents a frontrunning attack, please set a non-trivial initial deposit."
            );

            uint256 tokenBalance = IERC20Upgradeable(tokens[i].underlyingAddress).balanceOf(deployerAddress);
            uint256 initialDeposit = tokens[i].initialDeposit;

            require(
                tokenBalance >= initialDeposit,
                "Insufficient balance for initial deposit. Please deposit more tokens."
            );
        }

        vm.startBroadcast(deployerPrivateKey);

        // Deploy wrappers for each token
        for (uint256 i = 0; i < tokens.length; i++) {
            // Deploy the implementation, which disables initializers on construction
            vault = new ATokenVault(tokens[i].underlyingAddress, referralCode, IPoolAddressesProvider(poolAddressProvider));
            console.log("Vault impl deployed at: ", address(vault));

            console.log("Deploying proxy...");
            // Encode the initializer call
            bytes memory data = abi.encodeWithSelector(
                ATokenVault.initialize.selector,
                owner,
                fee,
                tokens[i].shareName,
                tokens[i].shareSymbol,
                tokens[i].initialDeposit
            );
            console.logBytes(data);

            address proxyAddr = computeCreateAddress(deployerAddress, vm.getNonce(deployerAddress) + 1);
            IERC20Upgradeable(tokens[i].underlyingAddress).approve(proxyAddr, tokens[i].initialDeposit);
            console.log("Precomputed proxy address: ", proxyAddr);
            console.log("Allowance for proxy: ", IERC20Upgradeable(tokens[i].underlyingAddress).allowance(deployerAddress, proxyAddr));

            // Deploy and initialize the proxy
            TransparentUpgradeableProxy proxy = new TransparentUpgradeableProxy(address(vault), proxyAdmin, data);
            console.log("Vault proxy deployed and initialized at: ", address(proxy));
        }
    
        vm.stopBroadcast();
    }
}
