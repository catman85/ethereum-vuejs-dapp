<template>
  <div class="row">
    <div class="col-md-3">

      <div class="form-group">
        <label for="description">Name</label>
        <input class="form-control" placeholder="Enter your name" type="text" v-model="userName">
      </div>

      <div class="form-group">
        <label for="description">Status</label>
        <input class="form-control" placeholder="Enter your status" type="text" v-model="userStatus">
      </div>

      <button class="btn btn-primary" :disabled="disableSubmit" @click="performSubmit">{{this.mode | capitalize}}</button>

      <!-- <strong class="text-danger"></strong> -->

      <div v-show="errorStr" class="alert alert-danger mt-3" role="alert">
        {{ errorStr }}
        <br>
        <small>Check the browser console for more details.</small>
      </div>

      <div v-show="successMessage" class="alert alert-success mt-3" role="alert">
        <strong>Success!</strong>
      </div>
    </div>
  </div>
</template>

<script>
import mixin from '../libs/mixinViews';

  export default {
    mixins: [mixin],
    name: 'MyForm',
    props: {
        mode: String
    },
    filters: {
        capitalize(s){
            return s.charAt(0).toUpperCase() + s.slice(1);
        }
    },
    data() {
      return {
        userName: '', // variable binded with the input field: name
        userStatus: '', // variable binded with the input field: status
        // submitting: false, // true once the submit button is pressed
        successMessage: false, // true when the user has been registered successfully

        // tmoConn: null, // contain the intervalID given by setInterval
        // tmoReg: null, // contain the intervalID given by setInterval
        errorStr: null, // it shows the error message
        hash: "hash-test"
      }
    },
    computed: {
      disableSubmit() {
        return (
          !this.userName.length ||
          !this.userStatus.length ||
          this.submitting ||
          !this.blockchainIsConnected()
        );
      }
    },
    methods: {
      /**
       * Perform the registration of the user when the submit button is pressed.
       *
       * @return {void}
       */
      performSubmit() {
        this.submitting = true;
        this.errorStr = null;
        this.successMessage = false;

        this.hash = this.userName; //FIXME: temporary use bcrypt instead

        if(this.mode == "sign"){
            this.$emit('sign',this.hash);
        }

        if(this.mode == "verify"){
            this.$emit('verify',this.hash);
        }
        // window.bc.getMainAccount()
        //   .then(address => this.performUserRegistration(address));
      },

      /**
       * Show the form error.
       *
       * @param {object} err
       * @return {void}
       */
      showErrorMessage(err) {
        console.error(err);

        this.errorStr = null;

        if (err) this.errorStr = err.toString();

        if (!this.errorStr) this.errorStr = 'Error occurred!';
      }
    }
  }

</script>
