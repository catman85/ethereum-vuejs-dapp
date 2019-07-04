<template>
  <div>
    <h1 class="title">Sign a Degree</h1>
    <h2>Welcome {{this.profName}}</h2>
    <h2>ID: {{this.profId}}</h2>
    <br>
    <MyForm mode="sign" @sign="signGraduation"></MyForm>
    <br>
    <h3>Address: {{this.profAddress}}</h3>
  </div>
</template>

<script>
  // importing common function
  import mixin from '../libs/mixinViews';
  import MyForm from '@/components/MyForm';

  export default {
    components: {MyForm},
    mixins: [mixin],

    data() {
      return {
      }
    },

    created() {
      // it checks every 500ms if the user is registered until the connection is established
    //   this.redirectIfUserRegistered();
        // console.debug(this.profName);
    },

    computed:{
        profName(){
            return this.$store.state.Prof.name
        },
        profAddress(){
            return this.$store.state.Prof.address
        },
        profId(){
            return this.$store.state.Prof.id
        }
    },

    methods: {
        /**
       * @param {string} hash
       * @return {Promise}
       */
      signGraduation(hash) { //only works when metamask poops the connect prompt ant the mozextension
        return new Promise((resolve, reject) => {
          window.bc.getAccounts()
            .then(accounts => {
              console.debug("Hash: ", hash);
              // accounts[0] is the selected MetaMask address
              window.bc.contract().signGraduation(hash, {
                from: accounts[0]
              }, (error, res) => {
                if (error) {
                  console.debug("Signing Failed!");
                  reject(error);
                }
                console.debug(res);
                resolve(res);
              })
              // .catch(error => { // mysterious undefined error
              // reject(error)
              // });
            })
        });
      },

      /**
       * Perform the user registration cannling the smart contract
       * function registerUser.
       *
       * @param {string} address
       * @return {void}
       */
    //   performUserRegistration(address) {
    //     window.bc.contract().registerUser(
    //       this.userName,
    //       this.userStatus, {
    //         from: address,
    //         gas: 800000
    //       },
    //       (err, txHash) => {
    //         this.submitting = false;

    //         if (err) {
    //           this.showErrorMessage(err);
    //         } else {
    //           this.successMessage = true;

    //           // it emits a global event in order to update the top menu bar
    //           Event.$emit('userregistered', txHash);

    //           // the transaction was submitted and the user will be redirected to the
    //           // profile page once the block will be mined
    //           this.redirectWhenBlockMined();
    //         }
    //       }
    //     )
    //   },

      /**
       * Check if the user visitng this page is registered: if the user is already
       * registered he will be redirected to the Profile page.
       *
       * @return {void}
       */
    //   redirectIfUserRegistered() {
    //     this.tmoConn = setInterval(() => {
    //       // checking first the connection
    //       if (this.blockchainIsConnected()) {
    //         // stopping the interval
    //         clearInterval(this.tmoConn);

    //         // calling the smart contract
    //         this.isRegistered().then(res => {
    //           if (res) {
    //             // redirecting to the profile page
    //             this.$router.push("profile");
    //           }
    //         });
    //       }
    //     }, 500);
    //   },

      /**
       * Once the user submitted his registration this funciton checks every 1000 ms
       * if the registration is successfully. Once the user is registered he will be
       * redirected to the profile page.
       *
       * NOTE: in order to check if the user has been registered successfully the
       * function has to check several time because the block can take several
       * minutes to be mined (depending on the the blockchain you are using).
       *
       * @return {void}
       */
    //   redirectWhenBlockMined() {
    //     this.tmoReg = setInterval(() => {
    //       if (this.blockchainIsConnected()) {
    //         this.isRegistered()
    //           .then(res => {
    //             if (res) {
    //               // stopping the setInterval
    //               clearInterval(this.tmoReg);

    //               // redirecting the user to the profile page
    //               this.$router.push("profile");
    //             }
    //           })
    //           .catch(error => this.showErrorMessage(error));
    //       }
    //     }, 1000);
    //   }
    }
  }

</script>
