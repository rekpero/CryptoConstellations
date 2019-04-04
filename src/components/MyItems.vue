<template>
    <div class="my-constellation">
        <Header></Header>
        <section class="home_banner_area">
            <div class="ui container app">
                <div class="marketplace">
                    <div class="ui stackable three cards">
                        <div v-for="(constellation, index) in constellations" v-bind:key="index" class="ui card">
                            <div class="constellation-name" v-bind:style="'background: #' + constellation.owner.substr(constellation.owner.length - 6) ">{{ constellation.name }}</div>
                            <div class="image-container">
                                <img v-bind:src="'https://ipfs.io/ipfs/' + constellation.ipfsHash" alt="constellation" style="width:100%">
                            </div>
                            <div class="owner-container" v-bind:style="'background: #' + constellation.owner.substr(constellation.owner.length - 6) ">
                                <h4>{{ constellation.owner.substr(constellation.owner.length - 6).toUpperCase() }}</h4>
                            </div>
                            <div class="description-container">
                                <p>{{ constellation.description }}</p>
                            </div>
                            <hr />
                            <div class="bidding-container" v-bind:style="'background: #' + constellation.owner.substr(constellation.owner.length - 6) ">
                                <div class="buy-constellation">
                                    <div class="buy-container">
                                        <a>{{ constellation.price.substr(0, 6) }} ETH</a>
                                        <button>Buy</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </div>
</template>

<script>
/* eslint-disable */
import CryptoConstellation from '@/js/cryptoconstellationcore'
import ipfs from '../ipfs.js'
import Header from '@/components/Header.vue'

export default {
    name: 'myConstellation',
    data () {
        return {
            constellations: [],
            constellation: {
                name: '',
                description: '',
                ipfsHash: '',
                owner: '',
                startingPrice: '',
                price: '',
                nextPrice: ''
            },
            totalMyToken: 0
        }
    },
    components: {
        Header
    },
    computed: {
        nickName: function () {
            return window.web3.eth.accounts[0].substr(window.web3.eth.accounts[0].length - 6).toUpperCase()
        }
    },
    beforeCreate: function () {
        
        CryptoConstellation.init().then(() => {
            CryptoConstellation.tokensOfOwner(window.web3.eth.accounts[0]).then((ownerTokens) => {

                for(let token_id=0; token_id < ownerTokens.length; token_id++){
                    
                    console.log(Number(ownerTokens[token_id]))
                    CryptoConstellation.getConstellation(Number(ownerTokens[token_id])).then(result => {
                        console.log(result)
                        this.constellations.push({
                            name: result[0],
                            description: result[1],
                            ipfsHash: result[2],
                            owner: result[3],
                            startingPrice: window.web3.fromWei(Number(result[4]), 'ether'),
                            price: window.web3.fromWei(Number(result[5]), 'ether'),
                            nextPrice: window.web3.fromWei(Number(result[6]), 'ether')
                        })
                    
                    })
                }
            })

            CryptoConstellation.tokenOf(window.web3.eth.accounts[0]).then((totalToken) => {
                console.log(Number(totalToken))
                this.totalMyToken = Number(totalToken)

            })
        }).catch(err => {
            console.log(err)
        })
    },
    methods: {
        
    }
}
</script>
<!-- Add "scoped" attribute to limit CSS to this component only -->
<style lang="scss" scoped>

@import url('https://fonts.googleapis.com/css?family=Roboto');
@import url("https://fonts.googleapis.com/css?family=Playfair+Display:700|Roboto:300,300i,400,500,600");
/*---------------------------------------------------- */
/*----------------------------------------------------*/
/*---------------------------------------------------- */
/*----------------------------------------------------*/
::-webkit-input-placeholder {
  /* WebKit, Blink, Edge */
  color: #999999;
  font-weight: 400; }

:-moz-placeholder {
  /* Mozilla Firefox 4 to 18 */
  color: #999999;
  opacity: 1;
  font-weight: 400; }

::-moz-placeholder {
  /* Mozilla Firefox 19+ */
  color: #999999;
  opacity: 1;
  font-weight: 400; }

:-ms-input-placeholder {
  /* Internet Explorer 10-11 */
  color: #999999;
  font-weight: 400; }

::-ms-input-placeholder {
  /* Microsoft Edge */
  color: #999999;
  font-weight: 400; }

.nick-name{
    margin-top: 28px;
    color: white;
    border-radius: 0.75rem;
    padding: 2px 10px;
}

.home_banner_area {
    padding-top:12%;
    padding-bottom:5.5%;
}


.my-constellation {
    height: 100%;
    background: -webkit-radial-gradient(rgb(0, 21, 113), rgb(2, 8, 15));
    background: radial-gradient(rgb(0, 21, 113), rgb(2, 8, 15));

}

.constellation-card-view {
    width: 100%;
    padding-top: 5%;
    padding-bottom: 5%;
    padding-left: 10%;
    padding-right: 10%;
    position: relative;
}

.ui.card {
  /* Add shadows to create the "card" effect */
    box-shadow: 0 4px 8px 0 rgba(0,0,0,0.2);
    transition: 0.3s;
    border-radius: 1rem; /* 5px rounded corners */
}

/* On mouse-over, add a deeper shadow */
/* .card:hover {
    box-shadow: 0 8px 16px 0 rgba(255, 255, 255, 0.2);
} */

.image-container img{
    width: 100%;
    height: 230px;
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
    background: rgb(104, 238, 77);
    border: none;
    color: white;
    font-size: 1rem;
    border-top-right-radius: 4px;
    border-bottom-right-radius: 4px; 
    padding:.5em 1.5em;
    line-height: 1em;

}

.description-container {
    padding-top: 15px;
    padding-bottom: 15px;
    padding-right: 20px;
    padding-left: 20px;
    height: 100px;
    overflow: auto;
    text-align: justify;
    font-family: 'Roboto', sans-serif;
}

.card hr {
    margin: 0;
}

.image-container {
    position: relative;
    text-align: center;
    color: white;
    height: 230px;
}

.constellation-name {
    text-align: center;
    font-family:'Gill Sans', 'Gill Sans MT', Calibri, 'Trebuchet MS', sans-serif;
    font-size: 25px;
    padding: 10px auto; 
    color: white;
    border-radius: 1rem 1rem 0 0; 
}
</style>
