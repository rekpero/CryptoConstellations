<template>
    <div class="add-constellation row">
        <div class="constellation-form col-sm-6">
            <h2>Add Constellation</h2>
            <div>
                <b-form-input id="constellation-name" v-model="constellation.name" required placeholder="Enter constellation name" ></b-form-input>
            </div>
            <div>
                <b-form-textarea id="constellation-description" v-model="constellation.description" required placeholder="Enter constellation description" ></b-form-textarea>
            </div>
            <div>
                <b-form-input id="constellation-price" v-model="constellation.price" required placeholder="Enter constellation price" ></b-form-input>
            </div>
            <div>
                <b-form-input id="constellation-owner" v-model="constellation.owner" required placeholder="Enter constellation owner address" ></b-form-input>
            </div>
            <div>
                <b-form-file v-model="constellation.image" class="mt-3" plain></b-form-file>
            </div>
            <div>
                <b-button block v-on:click="onSubmit" variant="primary">Submit</b-button>
            </div>
        </div>
        
        <div class="constellation-card-view col-sm-6">
            <div class="card">
                <div class="image-container">
                    <img v-bind:src="'https://ipfs.io/ipfs/' + constellation.ipfsHash" alt="constellation" style="width:100%">
                    <div class="constellation-name">{{ this.constellation.name }}</div>
                </div>
                <div class="owner-container" v-bind:style="'background: #'+ nickName">
                    <h4>{{ nickName }}</h4>
                </div>
                <div class="description-container">
                    <p>{{this.constellation.description}}</p>
                </div>
                <hr />
                <div class="bidding-container">
                    <div class="buy-constellation">
                        <div class="buy-container">
                            <a>{{ this.constellation.price }} ETH</a>
                            <button>Buy</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        

    </div>
</template>

<script>
/* eslint-disable */
import CryptoConstellation from '@/js/cryptoconstellationcore'
import ipfs from '../ipfs.js'

export default {
    name: 'addConstellation',
    data () {
        return {
            constellation: {
                name: '',
                description: '',
                price: '',
                owner: '',
                image: null,
                ipfsHash: ''
            }
        }
    },
    computed: {
        nickName() {
            return this.constellation.owner.substr(this.constellation.owner.length - 6).toUpperCase();
        }
    },
    beforeCreate: function () {
        
        CryptoConstellation.init().then(() => {
            console.log(CryptoConstellation.instance)
            console.log(window.web3.eth.accounts[0])
        }).catch(err => {
            console.log(err)
        })
    },
    methods: {
        onSubmit: function (e) {
            e.preventDefault()
            const reader = new window.FileReader()
            reader.readAsArrayBuffer(this.constellation.image)
            reader.onloadend = () => {
                console.log('buffer', Buffer(reader.result))
                const buffer = Buffer(reader.result)
                ipfs.add(buffer, (error, result) => {
                    if(error) {
                        console.error(error)
                        return
                    }
                    this.constellation.ipfsHash = result[0].hash
                    console.log('ipfsHash', this.constellation.ipfsHash)
                    CryptoConstellation.createConstellation(this.constellation.name, this.constellation.description, this.constellation.ipfsHash, window.web3.toWei(this.constellation.price, 'ether'), this.constellation.owner)
                    .then((tx) => {
                        
                    })
                })
            }

        }
    }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style lang="scss" scoped>
.add-constellation {
    height: 100vh;
    color: white;
    background: -webkit-radial-gradient(rgb(0, 21, 113), rgb(2, 8, 15));
    background: radial-gradient(rgb(0, 21, 113), rgb(2, 8, 15));

}

.constellation-form {
    width: 50%;
    padding-top: 5%;
    padding-bottom: 5%;
    padding-left: 10%;
    padding-right: 10%;
}
.constellation-form div {
    margin: 20px;
    align-content: center;
}

.constellation-card-view {
    width: 50%;
    padding-top: 5%;
    padding-bottom: 5%;
    padding-left: 10%;
    padding-right: 10%;
    position: relative;
}

.card {
  /* Add shadows to create the "card" effect */
    box-shadow: 0 4px 8px 0 rgba(0,0,0,0.2);
    transition: 0.3s;
    border-radius: 5px; /* 5px rounded corners */
}

/* On mouse-over, add a deeper shadow */
.card:hover {
    box-shadow: 0 8px 16px 0 rgba(0,0,0,0.2);
}

.image-container img{
    width: 100%;
    height: 230px;
    border-radius: 5px 5px 0 0;
}

/* Add some padding inside the card container */
.owner-container {
    padding: 6px;
    color: white;
    font-family: cursive;
}

.owner-container h4 {
    font-size: 20px;
}

.bidding-container {
    padding: 0.75em 1em;
    width: auto;
}

.buy-constellation {
    text-align: center;
}

.buy-container {
    display: inline-flex;
    padding: 0!important;
    font-size: 1rem;
}

.buy-container a {
    margin: 0 0 0 -1px!important;
    font-size: 1rem;
    background: white;
    border: 1px solid rgba(34,36,38,.15);
    color: black;
    box-shadow: none;
    padding:.5em 1.5em;
    border-top-left-radius: 4px;
    border-bottom-left-radius: 4px;
}

.buy-container button {
    background: blueviolet;
    border: none;
    color: white;
    font-size: 1rem;
    border-top-right-radius: 4px;
    border-bottom-right-radius: 4px; 
    padding:.5em 1.5em;
    line-height: 1em;

}

.description-container {
    margin-top: 15px;
    padding-right: 20px;
    padding-left: 20px;
    text-align: justify;
}

.card hr {
    margin: 0;
}

.image-container {
    position: relative;
    text-align: center;
    color: white;
    border-radius: 5px 5px 0 0;
    height: 230px;
}

.constellation-name {
    position: absolute;
    left: 50%;
    top: 8px;
    font-family:'Gill Sans', 'Gill Sans MT', Calibri, 'Trebuchet MS', sans-serif;
    font-size: 25px;
    transform: translateX(-50%);
}
</style>
