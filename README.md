[![Foundry][foundry-badge]][foundry]

[foundry]: https://getfoundry.sh/
[foundry-badge]: https://img.shields.io/badge/Built%20with-Foundry-FFDB1C.svg

# Aave Vault

An ERC-4626 vault which allows users to deposit/withdraw ERC-20 tokens supported by Aave v3, manages the supply and withdrawal of these assets in Aave, and allows a vault manager to take a fee on yield earned.

> **info**
> This bratch is dedicated to deploying aToken wrappers to Polygon and Mumbai Testnet.

## Instructions

To compile/build the project, run `forge build`.

## Tests

To test Polygon deployments run a deployment on the Mumbai Testnet.

Previous Mumbai deployments:


## Deployment

To deploy the vault contract, first check that the deployment parameters in `script/Deploy.s.sol` are configured correctly, then check that your `.env` file contains these keys:

```
PRIVATE_KEY=
ETHERSCAN_API_KEY=
POLYGON_RPC_URL=
MUMBAI_RPC_URL=
```

> **info**
> `ETHERSCAN_API_KEY` is required for smart contract verification. This key will be utilized for both Ethereum Mainnet and Sepolia Testnet. Etherscan provides simple documentation on how you can obtain a free API key [here](https://docs.etherscan.io/getting-started/viewing-api-usage-statistics). You only need one key for both networks. Add the key to the `ETHERSCAN_API_KEY` variable in your `.env` file.

> Similarly, `POLYGON_RPC_URL` AND `MUMBAI_RPC_URL` will be needed to make a connection to each respective network. You can obtain a free RPC URL from [Alchemy](https://dashboard.alchemy.com/).

### Alchemy RPC Url Creation
After creating an account on Alchemy, you will be directed to the dashboard. In the top right corner of the project table, click the "Create App" button. Select "Polygon PoS" from the network dropdown and either Mainnet or Mumbai. After creating you key select the newly creation key from the table in the dashboard. Select "View key" and copy the API key to your respective API_KEY `.env` variable (`POLYGON_RPC_URL` or `MUMBAI_RPC_URL`).

Initial deposits are required in order to help prevent exchange rate attacks on the aToken. A recommended deposit amount is between $50 and $100 per asset. The list of tokens and initial depsit values are already set within the `TokenRegistry` but can be changed if necessary. Please make sure the account you are deploying from contains these tokens before running the deployment script.

> **info**
> `_setState` initializes the necessary data for deploying tokens. If you would like to add or remove a token to the deployment group, you will need to update the `TokenRegistry` by editing `_setState`.

To begin the deployment, load in your environment variables by running:

```bash
source .env
```

Then run one of the following commands:

Mumbai Testnet:

```bash
forge script script/Deploy.s.sol:Deploy --rpc-url $MUMBAI_RPC_URL --broadcast --verify --legacy -vvvv
```

Polygon Mainnet:

```bash
forge script script/Deploy.s.sol:Deploy --rpc-url $POLYGON_RPC_URL --broadcast --verify --legacy -vvvv
```
