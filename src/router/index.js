import Vue from 'vue'
import Router from 'vue-router'
import Dashboard from '@/components/Dashboard'
import AddConstellation from '@/components/AddConstellation'
import MyItems from '@/components/MyItems'
import Marketplace from '@/components/Marketplace'
import Admin from '@/components/Admin'

Vue.use(Router)

export default new Router({
  mode: 'history',
  base: process.env.BASE_URL,
  routes: [
    {
      path: '/',
      name: 'dashboard',
      component: Dashboard
    },
    {
      path: '/my-items',
      name: 'my-items',
      component: MyItems
    },
    {
      path: '/add-constellation',
      name: 'add-constellation',
      component: AddConstellation
    },
    {
      path: '/dapp',
      name: 'dapp',
      component: Marketplace
    },
    {
      path: '/admin',
      name: 'admin',
      component: Admin
    }
  ]
})
