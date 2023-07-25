## Introduccion
WorkForce desplegado en avalanche

### NodeJS and Yarn

Importante! esto es nodo `14.17.0` por favor usar esta version.

Despues, instalar [yarn](https://yarnpkg.com):

```zsh
npm install -g yarn
```

### AvalancheGo y Avash

[AvalancheGo](https://github.com/ava-labs/avalanchego) Hay que correr esta implementacion de avalanche en go. [Avash](https://docs.avax.network/build/tools/avash) 


## Dependencias

Clone the [quickstart repository](https://github.com/ava-labs/avalanche-smart-contract-quickstart) and install the necessary packages via `yarn`.

```zsh
$ git clone https://github.com/DavidRaigozaJ/wrk-avalanche
$ cd wrk-avalanche
$ yarn
```

## Correr Hardhat

Los comandos para correr Hardhat son

```yarn hardhat node```  este comando corre la blockchain local
```yarn deploy --network localhost``` este comando desplega el contrato en la blockchain local de avalanche.
