<template>
    <header class="header_area">
        <div class="main_menu">
            <nav class="navbar navbar-expand-lg navbar-light">
                <div class="container">
                <!-- Brand and toggle get grouped for better mobile display -->
                    <router-link to="/"><a class="navbar-brand logo_h" style="color:#fff; font-weight:100;font-family: 'Playfair Display', serif;padding-top:20px;">Crypto <img src="https://res.cloudinary.com/mmitrasish/image/upload/v1554043886/logo.png" alt="logo" height="80px" width="80px"> Constellation</a></router-link>
                    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <!-- Collect the nav links, forms, and other content for toggling -->
                    <div class="collapse navbar-collapse offset" id="navbarSupportedContent">
                        <ul class="nav navbar-nav menu_nav ml-auto">
                            <li class="nav-item"><router-link to="/dapp"><a class="nav-link" >Catalogue</a></router-link></li>
                            <li class="nav-item"><a class="nav-link" >Leaderboard</a></li>
                            <li class="nav-item"><router-link to="/my-items"><a class="nav-link" >My Items ( {{ totalMyToken }} )</a></router-link></li>
                        </ul>
                        <ul class="nav navbar-nav ml-auto">
                            <li class="nav-item">
                                <div class="nick-name" v-bind:style="'background: #' + nickName ">{{ nickName }}</div>
                            </li>
                            <li class="nav-item" >
                                <img src="https://res.cloudinary.com/mmitrasish/image/upload/v1553985742/eth_online.svg" alt="ethereum-icon" height="40px" width="25px" style="margin-top:20px" />
                            </li>
                        </ul>
                    </div>
                </div>
            </nav>
        </div>
    </header>
</template>

<script>
/* eslint-disable */
import CryptoConstellation from '@/js/cryptoconstellationcore'

export default {
    name: 'marketplace',
    data () {
        return {
            totalMyToken: 0
        }
    },
    beforeCreate: function () {
        
        this.useraddress = window.web3.eth.accounts[0]
        console.log(this.useraddress)
        CryptoConstellation.init().then(() => {
            CryptoConstellation.tokenOf(window.web3.eth.accounts[0]).then((totalToken) => {
                console.log(Number(totalToken))
                this.totalMyToken = Number(totalToken)

            })
        }).catch(err => {
            console.log(err)
        })
    },
    computed: {
        nickName: function () {
            return window.web3.eth.accounts[0].substr(window.web3.eth.accounts[0].length - 6).toUpperCase()
        }
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
    padding-bottom:3%;
}

.header_area {
  position: absolute;
  width: 100%;
  z-index: 999999;
  transition: background 0.4s, all 0.3s linear; }
  .header_area .navbar {
    background: transparent;
    padding: 0px;
    border: 0px;
    border-radius: 0px; }
    .header_area .navbar .nav .nav-item {
      margin-right: 45px; }
      .header_area .navbar .nav .nav-item .nav-link {
        font: 600 12px/80px "Roboto", sans-serif;
        text-transform: uppercase;
        color: #ffffff;
        padding-top: 20px;
        display: inline-block; }
        .header_area .navbar .nav .nav-item .nav-link:after {
          display: none; }
        @media (max-width: 991px) {
          .header_area .navbar .nav .nav-item .nav-link {
            color: #ffffff; } }
      .header_area .navbar .nav .nav-item:hover .nav-link, .header_area .navbar .nav .nav-item.active .nav-link {
        color: #ff2f8b; }
      .header_area .navbar .nav .nav-item.submenu {
        position: relative; }
        .header_area .navbar .nav .nav-item.submenu ul {
          border: none;
          padding: 0px;
          border-radius: 0px;
          box-shadow: none;
          margin: 0px;
          background: #fff; }
          @media (min-width: 992px) {
            .header_area .navbar .nav .nav-item.submenu ul {
              position: absolute;
              top: 120%;
              left: 0px;
              min-width: 200px;
              text-align: left;
              opacity: 0;
              transition: all 300ms ease-in;
              visibility: hidden;
              display: block;
              border: none;
              padding: 0px;
              border-radius: 0px; } }
          .header_area .navbar .nav .nav-item.submenu ul:before {
            content: "";
            width: 0;
            height: 0;
            border-style: solid;
            border-width: 10px 10px 0 10px;
            border-color: #eeeeee transparent transparent transparent;
            position: absolute;
            right: 24px;
            top: 45px;
            z-index: 3;
            opacity: 0;
            transition: all 400ms linear; }
          .header_area .navbar .nav .nav-item.submenu ul .nav-item {
            display: block;
            float: none;
            margin-right: 0px;
            border-bottom: 1px solid #ededed;
            margin-left: 0px;
            transition: all 0.4s linear; }
            .header_area .navbar .nav .nav-item.submenu ul .nav-item.active {
              background: #ff2f8b; }
              .header_area .navbar .nav .nav-item.submenu ul .nav-item.active .nav-link {
                color: #fff; }
            .header_area .navbar .nav .nav-item.submenu ul .nav-item .nav-link {
              line-height: 45px;
              color: #000000;
              padding: 0px 30px;
              transition: all 150ms linear;
              display: block;
              margin-right: 0px; }
            .header_area .navbar .nav .nav-item.submenu ul .nav-item:last-child {
              border-bottom: none; }
            .header_area .navbar .nav .nav-item.submenu ul .nav-item:hover .nav-link {
              background: #ff2f8b;
              color: #fff; }
        @media (min-width: 992px) {
          .header_area .navbar .nav .nav-item.submenu:hover ul {
            visibility: visible;
            opacity: 1;
            top: 100%; } }
        .header_area .navbar .nav .nav-item.submenu:hover ul .nav-item {
          margin-top: 0px; }
      .header_area .navbar .nav .nav-item:last-child {
        margin-right: 0px; }
    .header_area .navbar .primary-btn {
      border: 1px solid #ffffff;
      padding: 7px 28px;
      color: #ffffff;
      letter-spacing: 1px;
      font-weight: 500;
      margin-top: 20px; }
      .header_area .navbar .primary-btn:hover {
        color: #ff2f8b;
        border: 1px solid #ff2f8b; }
      @media (max-width: 991px) {
        .header_area .navbar .primary-btn {
          display: none; } }
    .header_area .navbar .search {
      background: transparent;
      border: 0px;
      font-size: 12px;
      line-height: 60px;
      display: inline-block;
      color: #ffffff;
      padding-left: 30px;
      cursor: pointer; }
      @media (max-width: 991px) {
        .header_area .navbar .search {
          color: #ffffff; } }
      .header_area .navbar .search i {
        font-weight: 600; }
    .header_area.navbar_fixed .main_menu {
    position: fixed;
    width: 100%;
    top: -70px;
    left: 0;
    right: 0;
    background: #000000;
    -webkit-transform: translateY(70px);
    -moz-transform: translateY(70px);
    -ms-transform: translateY(70px);
    -o-transform: translateY(70px);
    transform: translateY(70px);
    -webkit-transition: all 0.3s ease 0s;
    -moz-transition: all 0.3s ease 0s;
    -o-transition: all 0.3s ease 0s;
    transition: all 0.3s ease 0s;
    box-shadow: 0px 3px 16px 0px rgba(0, 0, 0, 0.1); }
    .header_area.navbar_fixed .main_menu .navbar .nav .nav-item .nav-link {line-height: 70px; }
    .header_area.navbar_fixed .main_menu .navbar .primary-btn {margin-top: 15px; }
</style>
