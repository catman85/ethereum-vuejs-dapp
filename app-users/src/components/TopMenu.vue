<template>
  <nav class="navbar navbar-expand-lg navbar-light bg-light">
    <ul class="navbar-nav">
      <router-link tag="li" class="nav-link" to="/" exact>
        <a>Search for a Degree</a>
      </router-link>

      <router-link tag="li" class="nav-link" to="/profile" exact v-show="isProfessor">
        <a>Sign a Degree</a>
      </router-link>
      {{$store.getters.prof}}
      <li class="nav-link">
        <strong :class="connectedClass">
          {{ connectedText }}
        </strong>
      </li>
    </ul>
  </nav>
</template>

<script>
  // importing common function
  import mixin from '../libs/mixinViews';

  export default {
    mixins: [mixin],

    data() {
      return {
        tmoConn: null, // contain the intervalID given by setInterval
        tmoReg: null, // contain the intervalID given by setInterval
        connectedClass: 'text-danger', // bootstrap class for the connection status (red when not connected, green when connected)
        connectedText: 'Not Connected',
        isProfessor: false, // true when the user that is visiting the page is registered
      }
    },

    created() {
      // when the event userregistered is fired (from the view Register.vue)
      // it runs the function checkUntilUserIsRegistered
      // Event.$on('userregistered', this.checkUntilUserIsRegistered);

      this.checkIfConnected();
      this.checkIfUserIsProfessor();
    },

    methods: {
      /**
       * It checks if the visiting user is regitered calling every 500ms the function isRegistered
       * from the smart contract until the connection with the smart contract is established.
       */
      checkIfConnected() {
        this.tmoConn = setInterval(() => {
          // checking first if the connection with the blockchain is established
          if (this.blockchainIsConnected()) {
            // stopping the setInterval
            clearInterval(this.tmoConn);

            // showing the connected message on the top bar and setting the class too
            this.goGreen();

            // commented because it through an error
            // this.isRegistered()
            // .then(res => this.userIsRegistered = res)
            // .catch(error => console.log(error));
          }
        }, 500);
      },

      goGreen() {
        this.connectedClass = 'text-success';
        this.connectedText = 'Connected';
      },

      showLink(){
        this.isProfessor = true;
      },

      /**
       * Check if the user is registered calling the function of the smart contract getProfessorIndex.
       */
      checkIfUserIsProfessor() {
        //   setInterval(() => {
              if (this.blockchainIsConnected()) {
                    // stopping the setInterval
                    // clearInterval(this.tmoConn);
                  console.debug("chk");
                  this.getProfessorIndex() //from ../libs/mixinViews/
                  .then((error, res) => {
                      if (res) {
                        //   console.debug(res);
                          this.showLink();
                      }
                      console
                  })
                  .catch(error => console.log(error))
              }
        // }, 500);
      }
    }
  }

</script>

<style>
</style>
