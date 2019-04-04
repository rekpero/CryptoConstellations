<template>
    <div class="admin">
        <div class="title">
            <h2>Admin</h2>
        </div>
        <div class="set1 row">
            <div class="col-sm-6">
                <div class="card">
                    <h2>Set New CEO</h2>
                    <div>
                        <b-form-input v-model="ceoAddress" required placeholder="Enter new CEO Address" ></b-form-input>
                    </div>
                    <div>
                        <b-button block v-on:click="setCEO" variant="primary">Set</b-button>
                    </div>
                </div>
                
            </div>
            
            <div class="col-sm-6">
                <div class="card">
                    <h2>Set New CTO</h2>
                    <div>
                        <b-form-input v-model="ctoAddress" required placeholder="Enter new CTO Address" ></b-form-input>
                    </div>
                    <div>
                        <b-button block v-on:click="setCTO" variant="primary">Set</b-button>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="set2 row">
            <div class="col-sm-6">
                <div class="card">
                    <h2>Set New COO</h2>
                    <div>
                        <b-form-input v-model="cooAddress" required placeholder="Enter new COO Address" ></b-form-input>
                    </div>
                    <div>
                        <b-button block v-on:click="setCOO" variant="primary">Set</b-button>
                    </div>
                </div>
            </div>
            
            <div class="col-sm-6">
                <div class="card">
                    <h2>Set New CFO</h2>
                    <div>
                        <b-form-input v-model="cfoAddress" required placeholder="Enter new CFO Address" ></b-form-input>
                    </div>
                    <div>
                        <b-button block v-on:click="setCFO" variant="primary">Set</b-button>
                    </div>
                </div>
            </div>
        </div>

        <div class="set3 row">
            <div class="col-sm-6">
                <div class="card">
                    <h2 style="margin-bottom:45px; margin-top:20px;">Withdraw All Amount</h2>
                    <div>
                        <b-button block v-on:click="withdrawAll" variant="primary">Withdraw All</b-button>
                    </div>
                </div>
            </div>
            
            <div class="col-sm-6">
                <div class="card">
                    <h2>Withdraw Amount</h2>
                    <div>
                        <b-form-input v-model="withdrawAmount" required placeholder="Withdraw Amount (ETH)"></b-form-input>
                    </div>
                    <div>
                        <b-button block v-on:click="withdrawSomeAmount" variant="primary">Withdraw Amount</b-button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
/* eslint-disable */
import CryptoConstellation from '@/js/cryptoconstellationcore'

export default {
    name: 'admin',
    data () {
        return {
            ceoAddress: '',
            ctoAddress: '',
            cooAddress: '',
            cfoAddress: '',
            withdrawAmount: ''
        }
    },
    computed: {
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
        setCEO: function(){
            CryptoConstellation.setCEO(this.ceoAddress).then((tx) => {
                console.log(tx)
            })
        },
        setCTO: function(){
            CryptoConstellation.setCTO(this.ctoAddress).then((tx) => {
                console.log(tx)
            })
        },
        setCFO: function(){
            CryptoConstellation.setCFO(this.cfoAddress).then((tx) => {
                console.log(tx)
            })
        },
        setCOO: function(){
            CryptoConstellation.setCOO(this.cooAddress).then((tx) => {
                console.log(tx)
            })
        },
        withdrawAll: function(){
            CryptoConstellation.withdrawAll().then((tx) => {
                console.log(tx)
            })
        },
        withdrawSomeAmount: function(){
            CryptoConstellation.withdrawAmount(window.web3.toWei(this.withdrawAmount, 'ether')).then((tx) => {
                console.log(tx)
            })
        }
    }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style lang="scss" scoped>

.admin {
    height: 100%;
    background: -webkit-radial-gradient(rgb(0, 21, 113), rgb(2, 8, 15));
    background: radial-gradient(rgb(0, 21, 113), rgb(2, 8, 15));

}

.card {
  /* Add shadows to create the "card" effect */
    box-shadow: 0 4px 8px 0 rgba(0,0,0,0.2);
    transition: 0.3s;
    border-radius: 5px; /* 5px rounded corners */
    padding: 20px;
    margin: 50px;

}

/* On mouse-over, add a deeper shadow */
.card:hover {
    box-shadow: 0 8px 16px 0 rgba(0,0,0,0.2);
}

.card hr {
    margin-bottom: 20px;
}

.card div {
    margin-bottom: 20px;
    width: 75%;
    margin-left: auto;
    margin-right: auto;
}

.title h2{
    margin: auto;
    color: white;
    padding-top: 20px;
    font-family: 'Playfair Display', serif;
    font-weight: 800;
    font-size: 40px;
}

</style>
