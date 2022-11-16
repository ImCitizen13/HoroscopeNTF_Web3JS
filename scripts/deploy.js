const hre = require("hardhat"); 
 
async function main() {  
 
    const horoscopeNFT = await hre.ethers.getContractFactory("horoscopeNFT");
    const hscp = await horoscopeNFT.deploy();   
    await hscp.deployed();
 
    //since we are testing, you should mention your own Eth wallet address
    const myAddress="0x2CdC506d5692e7C431f48f9910cAe80d02B1f30d";
    console.log("horoscopeNFT deployed to:", hscp.address);   
 
    // let txn = await hscp.mintNFT(myAddress, 'virgo');
    await txn.wait();
 
}
 
main()
    .then(() => process.exit(0))  
    .catch((error) => {    
    console.error(error);
    process.exit(1); 
 });