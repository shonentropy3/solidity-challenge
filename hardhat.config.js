require('@openzeppelin/hardhat-upgrades');

const PRIVATE_KEY = "0a4544f2284a4949f8ec6271b828e6a3efff00e3208cbeaf870af991e8cd192f"


/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
    solidity: "0.8.17",
//    gasPrice:2000000000,
    timeout: 200_000_000,
    networks: {
        match_main: {
            url: "https://rpc-sen.matchscan.io",
            accounts: [`${PRIVATE_KEY}`]
        },

        match_test: {
            url: "https://testnet-rpc.d2ao.com/",
            accounts: [`${PRIVATE_KEY}`]
        },

        match_test_9000: {
            url: "https://mat-testnet-rpc.matchscan.io/",
            accounts: [`${PRIVATE_KEY}`]
        },

        tomo_main: {
            url: "https://rpc.tomochain.com",
            accounts: [`${PRIVATE_KEY}`]
        },

        bsc: {
            url: "https://bscrpc.com",
            accounts: [`${PRIVATE_KEY}`]
        },

        bsc_test: {
            url: "https://bsc-testnet.publicnode.com",
            accounts: [`${PRIVATE_KEY}`]
        },

        eth: {
            url: "https://eth.llamarpc.com",
            accounts: [`${PRIVATE_KEY}`]
        },

        polygon: {
            url: "https://polygon-rpc.com",
            accounts: [`${PRIVATE_KEY}`]
        },

        polygon_mumbai: {
            url: "https://polygon-mumbai.g.alchemy.com/v2/aTeMr0QAMOw2iebPLl9E5rQFe6jNaZYn",
            accounts: [`${PRIVATE_KEY}`]
        },

        heco: {
            url: "https://http-mainnet.hecochain.com",
            accounts: [`${PRIVATE_KEY}`]
        },
        esc: {
            url: "https://seed4.evanesco.org:8546",
            accounts: [`${PRIVATE_KEY}`]
        },

        ftm: {
            url: "https://rpc.ftm.tools",
            accounts: [`${PRIVATE_KEY}`]
        },

        avax: {
            url: "https://api.avax.network/ext/bc/C/rpc",
            accounts: [`${PRIVATE_KEY}`]
        },
    }
};
