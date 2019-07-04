import Vue from 'vue'
import Vuex from 'vuex'

Vue.use(Vuex)

export const store = new Vuex.Store({
  state:{
    test: 'hello'
  },
  mutations: {
    change(state, flavor) {
      state.test = flavor
    }
  },
  getters: {
    test: state => state.test
  }
})
