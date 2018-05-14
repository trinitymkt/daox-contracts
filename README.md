# Daox Contracts

[![Logo](https://raw.githubusercontent.com/daox/daox-contracts/master/assets/daox-logo_github@2x.png)](https://daox.org/)

[![Build Status](https://travis-ci.org/daox/daox-contracts.svg?branch=master)](https://travis-ci.org/daox/daox-contracts)

This repo contains Solidity smart contracts to create decentralized autonomous organizations for [the Daox platform](https://platform.daox.org).

Install
-------

### Clone the repository:

```bash
git clone https://github.com/daox/daox-contracts.git
cd daox-contracts
```

### Install requirements with npm:

```bash
npm i
```

### Install truffle and ganache-cli for testing and compiling:

```bash
npm i -g truffle ganache-cli
```

Testing
-------------------
### Run all tests (will automatically run ganache-cli in the background):

```bash
npm test
```

Compile and Deploy
------------------
Compiled contracts are already stored in repository so in regular case you will not need to compile it. 
But if it is needed for some reason use instructions below

### Compile all contracts:

```bash
truffle compile
```

License
-------
All smart contracts are released under MIT.

Contributors
------------
- Anton Vityazev ([GiddeonWyeth](https://github.com/GiddeonWyeth))
- Kirill Bulgakov ([bulgakovk](https://github.com/bulgakovk))
- Alexander Shevlyakov ([sanchosrancho](https://github.com/sanchosrancho))