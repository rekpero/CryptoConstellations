/* eslint-disable */

import contract from 'truffle-contract'
import CryptoConstellationContract from '@contracts/CryptoConstellationCore.json'

const CryptoConstellationCore = {
    contract: null,

    instance: null,

    init: function () {
        let self = this

        return new Promise(function (resolve, reject) {
            self.contract = contract(CryptoConstellationContract)
            self.contract.setProvider(window.web3.currentProvider)

            self.contract.deployed().then(instance => {
                self.instance = instance
                resolve()
            }).catch(err => {
                reject(err)
            })
        })
    },

    getConstellation: function (id) {
        let self = this

        return new Promise((resolve, reject) => {
            self.instance.getConstellation.call(
                id, {from: window.web3.eth.accounts[0]}
            ).then(result => {
                resolve(result)
            }).catch(err => {
                reject(err)
            })
        })
    },

    tokensOfOwner: function (owner) {
        let self = this

        return new Promise((resolve, reject) => {
            self.instance.tokensOfOwner.call(
                owner, {from: window.web3.eth.accounts[0]}
            ).then(ownerTokens => {
                resolve(ownerTokens)
            }).catch(err => {
                reject(err)
            })
        })
    },

    createConstellation: function (name, description, ipfsHash, price, owner) {
        let self = this

        return new Promise((resolve, reject) => {
            self.instance.createConstellation(
                name, description, ipfsHash, price, owner,
                {from: window.web3.eth.accounts[0], gas: 1000000}
            ).then(tx => {
                resolve(tx)
            }).catch(err => {
                reject(err)
            })
        })
    },

    buy: function (tokenId, price) {
        let self = this

        return new Promise((resolve, reject) => {
            self.instance.buy(
                tokenId, {from: window.web3.eth.accounts[0], value: price}
            ).then(tx => {
                resolve(tx)
            }).catch(err => {
                reject(err)
            })
        })
    },

    withdrawAll: function () {
        let self = this

        return new Promise((resolve, reject) => {
            self.instance.withdrawAll(
                {from: window.web3.eth.accounts[0]}
            ).then(tx => {
                resolve(tx)
            }).catch(err => {
                reject(err)
            })
        })
    },

    withdrawAmount: function (amount) {
        let self = this

        return new Promise((resolve, reject) => {
            self.instance.withdrawAmount(
                amount, {from: window.web3.eth.accounts[0]}
            ).then(tx => {
                resolve(tx)
            }).catch(err => {
                reject(err)
            })
        })
    },

    setNickName: function (user, nickName) {
        let self = this

        return new Promise((resolve, reject) => {
            self.instance.setNickName(
                user, nickName, {from: window.web3.eth.accounts[0]}
            ).then(tx => {
                resolve(tx)
            }).catch(err => {
                reject(err)
            })
        })
    },

    setCEO: function (newCEO) {
        let self = this

        return new Promise((resolve, reject) => {
            self.instance.setCEO(
                newCEO, {from: window.web3.eth.accounts[0]}
            ).then(tx => {
                resolve(tx)
            }).catch(err => {
                reject(err)
            })
        })
    }, 

    setCTO: function (newCTO) {
        let self = this

        return new Promise((resolve, reject) => {
            self.instance.setCTO(
                newCTO, {from: window.web3.eth.accounts[0]}
            ).then(tx => {
                resolve(tx)
            }).catch(err => {
                reject(err)
            })
        })
    }, 

    setCFO: function (newCFO) {
        let self = this

        return new Promise((resolve, reject) => {
            self.instance.setCFO(
                newCFO, {from: window.web3.eth.accounts[0]}
            ).then(tx => {
                resolve(tx)
            }).catch(err => {
                reject(err)
            })
        })
    }, 

    setCOO: function (newCOO) {
        let self = this

        return new Promise((resolve, reject) => {
            self.instance.setCOO(
                newCOO, {from: window.web3.eth.accounts[0]}
            ).then(tx => {
                resolve(tx)
            }).catch(err => {
                reject(err)
            })
        })
    },
    totalSupply: function () {
        let self = this

        return new Promise((resolve, reject) => {
            self.instance.totalSupply(
                {from: window.web3.eth.accounts[0]}
            ).then(totalTokens => {
                resolve(totalTokens)
            }).catch(err => {
                reject(err)
            })
        })
    },
    tokenOf: function (address) {
        let self = this

        return new Promise((resolve, reject) => {
            self.instance.balanceOf(
                address, {from: window.web3.eth.accounts[0]}
            ).then(totalTokens => {
                resolve(totalTokens)
            }).catch(err => {
                reject(err)
            })
        })
    }
}

export default CryptoConstellationCore
