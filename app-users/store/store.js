import Vue from 'vue'
import Vuex from 'vuex'

Vue.use(Vuex)

export default new Vuex.Store({
  state:{
    isProf: false,
    Prof: {
      id: -1,
      name: "",
      address : ""
    }
  },
  mutations: {
    setProf(state, id, name, address) {
      state.Prof.id = id;
      state.Prof.name = name;
      state.Prof.address = address;
    }
  },
  getters: {
    isProf: state => state.isProf,
    prof(state){
      return state.Prof;
    }
  }
})
