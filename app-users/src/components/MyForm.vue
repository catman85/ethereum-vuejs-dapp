<template>
  <div class="row">
    <div class="col-md-3">

      <div class="form-group">
        <label for="description">Name</label>
        <input class="form-control" placeholder="Enter name" type="text" v-model="userName">
      </div>

      <div class="form-group">
        <label for="description">Department</label>
        <input class="form-control" placeholder="Enter department" type="text" v-model="department">
      </div>

      <div class="form-group">
        <label for="description">Grade</label>
        <input class="form-control" placeholder="Enter grade" type="text" v-model="grade">
      </div>
      <!-- TODO: bootstraap date picker -->
      <div class="form-group">
        <div class='input-group date' id='datetimepicker1'>
          <input type='text' class="form-control" />
          <span class="input-group-addon">
            <span class="glyphicon glyphicon-calendar"></span>
          </span>
        </div>
      </div>
      <div class="form-group">
        <label for="description">Date</label>
        <input class="form-control" placeholder="Enter grade" type="text" v-model="grade">
      </div>

      <button class="btn btn-primary" :disabled="disableSubmit"
        @click="performSubmit">{{this.mode | capitalize}}</button>

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

  // ATTENTION importing the client-side hash library 
  import bcrypt from "bcryptjs"; //bcrypt
  import crypto from "crypto-js"; //sha256

  export default {
    mixins: [mixin],
    name: 'MyForm',
    props: {
      mode: String
    },
    filters: {
      capitalize(s) {
        return s.charAt(0).toUpperCase() + s.slice(1);
      }
    },
    data() {
      return {
        userName: '', // variable binded with the input field: name
        department: '', // variable binded with the input field: status
        grade: 0,

        successMessage: false, // true when the user has been registered successfully
        // tmoConn: null, // contain the intervalID given by setInterval
        // tmoReg: null, // contain the intervalID given by setInterval
        errorStr: null, // it shows the error message
        hash: String,
        date: String
      }
    },
    mounted() {
      // BCRYPT too complicated
      // var salt = bcrypt.genSaltSync(10);
      // var hash = bcrypt.hashSync("test", salt);
      // console.debug(hash);
      // console.debug(bcrypt.compareSync("test", hash));
    },
    computed: {
      disableSubmit() {
        return (
          !this.userName.length ||
          !this.department.length ||
          !this.blockchainIsConnected()
        );
      }
    },
    methods: {
      /**
       * @return {void}
       */
      performSubmit() {
        //TODO: build the concat method
        this.hash = this.sha256(this.data); //FIXME: temporary use bcrypt instead

        if (this.mode == "sign") {
          this.$emit('sign', this.hash); // calls contract function in Sign.vue
        }

        if (this.mode == "verify") {
          this.$emit('verify', this.hash); // calls contract funcion in Verify.vue
        }
        // window.bc.getMainAccount()
        //   .then(address => this.performUserRegistration(address));
      },

      concat() {

      },

      sha256(data) {
        let Crypto = require('crypto-js')
        let res = Crypto.SHA256(data).toString();
        console.debug(res);
        return res;
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
