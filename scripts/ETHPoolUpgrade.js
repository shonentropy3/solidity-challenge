const {ethers, upgrades} = require("hardhat");

// const proxyAddress = "0x7b26CEFe8562F0D874Fbd051aF106829926Ccd03"
const proxyAddress = "0xb334d3ae4357aCbb2aa18162fb720f18162eF885"
// 0x1B504173bD4da2156504873171edcEeaa70CDe49  getImplementationAddress
// 0x6144C62e0144a47C7b22BDEb21A5Bb74a62B0d3c  getAdminAddress
async function main() {
    console.log(proxyAddress, " original proxy address")
    const ETHPool = await ethers.getContractFactory("ETHPool")
    const myOpenProxyV2 = await upgrades.upgradeProxy(proxyAddress, ETHPool)
    console.log(myOpenProxyV2.address, " OpenProxyV2 address(should be the same)")

    console.log(await upgrades.erc1967.getImplementationAddress(myOpenProxyV2.address), " getImplementationAddress")
    console.log(await upgrades.erc1967.getAdminAddress(myOpenProxyV2.address), " getAdminAddress")
}

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});
