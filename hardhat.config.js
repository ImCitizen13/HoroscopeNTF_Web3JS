/**
 * @type import('hardhat/config').HardhatUserConfig
 */
 require('dotenv').config(); //all the key value pairs are being made available due to this lib
 require("@nomicfoundation/hardhat-toolbox");
 require("@nomiclabs/hardhat-etherscan");
    
 module.exports = {
   solidity: "0.8.9",
   defaultNetwork: 'goerli',
   networks: {
     hardhat: {},
     goerli: {
         url: process.env.API_URL_KEY,
         accounts: [`0x${process.env.PRIVATE_KEY}`]
     }
   },
   etherscan: {
    // Your API key for Etherscan
    // Obtain one at https://etherscan.io/
    apiKey: process.env.YOUR_ETHERSCAN_API_KEY
  }
 };