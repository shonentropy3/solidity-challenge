
const { ethers, upgrades } = require("hardhat")

// 可升级合约
async function main() {

  const ETHPool = await ethers.getContractFactory(
    "ETHPool"
  )
  console.log("Deploying ethPool .........")

//   需要给metaData、metaDividend权限，可以调合约
  const ethPool = await upgrades.deployProxy(ETHPool);
  console.log("ethPool  proxy address is ",ethPool.address)
  
}

// npx 
// test地址
// proxy address is  0xfB6317F4e57859879Abd3e26afA19426eAD1521C

// pro地址


main()
  .then(() => process.exit(0))
  .catch(error => {
    console.error(error);
    process.exit(1);
  });