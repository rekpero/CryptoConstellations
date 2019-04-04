/* eslint-disable */
// The Vue build version to load with the `import` command
// (runtime-only or standalone) has been set in webpack.base.conf with an alias.
import Vue from 'vue'
import App from './App'
import Web3 from 'web3'
import router from './router'
import BootstrapVue from 'bootstrap-vue'
import 'bootstrap/dist/css/bootstrap.css'
import 'bootstrap-vue/dist/bootstrap-vue.css'
import 'semantic-ui/dist/semantic.min.css'
import 'semantic-ui/dist/semantic.min.js'
import 'particlesjs/dist/particles.min.js'
import './assets/css/bootstrap.css'
import './assets/vendors/linericon/style.css'
import './assets/css/font-awesome.min.css'
import './assets/css/magnific-popup.css'
import './assets/vendors/owl-carousel/owl.carousel.min.css'
import './assets/vendors/nice-select/css/nice-select.css'
import VueParticles from 'vue-particles'

Vue.use(VueParticles)
Vue.use(BootstrapVue)

Vue.config.productionTip = false

window.addEventListener('load', async () => {
  if (window.ethereum) {
    window.web3 = new Web3(ethereum)
    try {
        // Request account access if needed
        await ethereum.enable()
        // Acccounts now exposed
        web3.eth.sendTransaction({/* ... */})
    } catch (error) {
        // User denied account access...
    }
  }
  // Legacy dapp browsers...
  else if (window.web3) {
    window.web3 = new Web3(web3.currentProvider)
    // Acccounts always exposed
    web3.eth.sendTransaction({/* ... */})
  }
  // Non-dapp browsers...
  else {
    console.log('Non-Ethereum browser detected. You should consider trying MetaMask!')
    // fallback - use your fallback strategy (local node / hosted node + in-dapp id mgmt / fail)
    window.web3 = new Web3(new Web3.providers.HttpProvider('http://localhost:7545'))
  }

  new Vue({
    el: '#app',
    router,
    template: '<App/>',
    components: { App }
  })
})

