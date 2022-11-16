const hre = require("hardhat"); 

async function main() {
  
    const horoscopeNFT = await hre.ethers.getContractFactory("horoscopeNFT");
    const hscp = await horoscopeNFT.deploy();
 
    //since we are testing, you should mention your own Eth wallet address
    const myAddress="0x2CdC506d5692e7C431f48f9910cAe80d02B1f30d";

  const WAIT_BLOCK_CONFIRMATIONS = 6;
  await hscp.deployTransaction.wait(WAIT_BLOCK_CONFIRMATIONS);

  console.log(`Contract deployed to ${hscp.address} on ${hre.network.name}`);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});