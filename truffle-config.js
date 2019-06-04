require('chai/register-should');

module.exports = {
  networks: {
    development: {
     host: "127.0.0.1",
     port: 8545,
     network_id: "*", // eslint-disable-line camelcase
    },
    coverage: {
      host: "127.0.0.1",
      port: 8555,
      gas: 0xfffffffffff,
      gasPrice: 0x01,
      network_id: "*", // eslint-disable-line camelcase
    },
  },
  compilers: {
    solc: {
      version: "0.5.7",
    }
  }
}
