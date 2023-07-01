[![Foundry][foundry-badge]][foundry]

[foundry]: https://getfoundry.sh/
[foundry-badge]: https://img.shields.io/badge/Built%20with-Foundry-FFDB1C.svg

# Aave Vault

An ERC-4626 vault which allows users to deposit/withdraw ERC-20 tokens supported by Aave v3, manages the supply and withdrawal of these assets in Aave, and allows a vault manager to take a fee on yield earned.

> **info**
> This bratch is dedicated to deploying aToken wrappers to Ethereum Mainnet and Sepolia Testnet.

## Instructions

To compile/build the project, run `forge build`.

## Tests

To test Ethereum deployments run a deployment on the Sepolia Testnet.

Previous Sepolia deployments:


## Deployment

To deploy the vault contract, first check that the deployment parameters in `script/Deploy.s.sol` are configured correctly, then check that your `.env` file contains these keys:

```
PRIVATE_KEY=
SEPOLIA_RPC_URL=
MAINNET_RPC_URL=
ETHERSCAN_API_KEY=
```

> **info**
> `ETHERSCAN_API_KEY` is required for smart contract verification. This key will be utilized for both Ethereum Mainnet and Sepolia Testnet. Etherscan provides simple documentation on how you can obtain a free API key [here](https://docs.etherscan.io/getting-started/viewing-api-usage-statistics). You only need one key for both networks. Add the key to the `ETHERSCAN_API_KEY` variable in your `.env` file.

> Similarly, `MAINNET_RPC_URL` AND `SEPOLIA_RPC_URL` will be needed to make a connection to each respective network. You can obtain a free RPC URL from [Infura](https://app.infura.io/register).

### Infura RPC Url Creation
After creating an account on Infura, you will be directed to the API Key homepage. In the top right corner, under settings, click the "Create New API Key" button. Select "Web3 API" from the network dropdown and give your API key a name. After creating you key select the newly creation key from the table in the API Key homepage. There you will see a list of available endpoints. Scroll down to Ethereum and you can toggle between the Mainnet and Sepolia Testnet RPC URLs. Copy each URL and them to the respective `.env` variable, `MAINNET_RPC_URL` AND `SEPOLIA_RPC_URL`. 

Initial deposits are required in order to help prevent exchange rate attacks on the aToken. A recommended deposit amount is between $50 and $100 per asset. The list of tokens and initial depsit values are already set within the `TokenRegistry` but can be changed if necessary. Please make sure the account you are deploying from contains these tokens before running the deployment script.

> **info**
> `_setState` initializes the necessary data for deploying tokens. If you would like to add or remove a token to the deployment group, you will need to update the `TokenRegistry` by editing `_setState`.

To begin the deployment, load in your environment variables by running:

```bash
source .env
```

Then run one of the following commands:

Sepolia Testnet:

```bash
forge script script/Deploy.s.sol:Deploy --rpc-url $SEPOLIA_RPC_URL --broadcast --verify --legacy -vvvv
```

Mainnet:

```bash
forge script script/Deploy.s.sol:Deploy --rpc-url $MAINNET_RPC_URL --broadcast --verify --legacy -vvvv
```
