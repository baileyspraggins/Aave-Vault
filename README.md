[![Foundry][foundry-badge]][foundry]

[foundry]: https://getfoundry.sh/
[foundry-badge]: https://img.shields.io/badge/Built%20with-Foundry-FFDB1C.svg

# Wrapped aToken Vault

An ERC-4626 vault which allows users to deposit/withdraw ERC-20 tokens supported by Aave v3, manages the supply and withdrawal of these assets in Aave, and allows a vault manager to take a fee on yield earned.

> **info**
> This bratch is dedicated to deploying aToken wrappers to Avalanche C-Chain and Avalanches Fuji Testnet.

## Instructions

To compile/build the project, run `forge build`.

## Tests

To test Avalanche deployments run a forked test deployment.

Previous Fork test deployment:

- [waUSDC](https://testnet.snowtrace.io/address/0xC9cC794F224648616E14f3E4F548FE76C21e64dd)
- [waUSDT](https://testnet.snowtrace.io/address/0xeA2fA5c25298BFf977aDE5F29dd960DF9EA7Bc56)

## Deployment

To deploy the vault contract, first check that the deployment parameters in `script/Deploy.s.sol` are configured correctly, then check that your `.env` file contains these keys:

```
PRIVATE_KEY=
FUJI_RPC_URL=
FUJI_API_KEY=
AVALANCHE_API_KEY=
AVALANCHE_RPC_URL=
```

Initial deposits are required in order to help prevent exchange rate attacks on the aToken. A recommended deposit amount is between $50 and $100 per asset. The list of tokens and initial depsit values are already set within the `TokenRegistry` but can be changed if necessary. Please make sure the account you are deploying from contains these tokens before running the deployment script.

> **info**
> `_setState` initializes the necessary data for deploying tokens. If you would like to add or remove a token to the deployment group, you will need to update the `TokenRegistry` by editing `_setState`.

To begin the deployment, load in your environment variables by running:

```bash
source .env
```

Then run one of the following commands:

Fuji Testnet:

```bash
forge script script/Deploy.s.sol:Deploy --rpc-url $FUJI_RPC_URL --broadcast --verify --legacy -vvvv
```

Avalanche C-Chain:

```bash
forge script script/Deploy.s.sol:Deploy --rpc-url $AVALANCHE_RPC_URL --broadcast --verify --legacy -vvvv
```
