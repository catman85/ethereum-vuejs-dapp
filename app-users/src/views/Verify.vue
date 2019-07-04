<template>
  <div>
    <h1 class="title">Verify a Degree</h1>

    <MyForm mode="verify" @verify="checkIfHashIsRegistered"></MyForm>

    <!-- <div class="clearfix"></div>

    <h2 v-show="!bcConnected">Not connect to the blockchain: please wait.</h2>

    <h2 v-show="(isLoading && bcConnected)">Loading...</h2>

    <table class="table table-striped" v-show="!isLoading">
      <thead class="thead-dark">
        <tr>
          <th>User ID</th>
          <th>Name</th>
          <th>Status</th>
          <th>Address</th>
          <th>Created At</th>
          <th>Updated At</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="user in users" :key="user">
          <td>{{ user[0].toNumber() }}</td>
          <td>{{ user[1] }}</td>
          <td>{{ toAscii(user[2]) }}</td>
          <td>{{ user[3] }}</td>
          <td>{{ toDate( user[4].toNumber() ) }}</td>
          <td>{{ toDate( user[5].toNumber() ) }}</td>
        </tr>
      </tbody>
    </table> -->
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
        users: [], // array that stores all the registered users
        isLoading: true, // true when the user list is loading form the blockchain
        bcConnected: false, // blockchain is connected ()
        tmoConn: null, // contain the intervalID given by setInterval
      }
    },
    created() {
      // it tries to get the user list from the blockchian once
      // the connection is established
      // this.tmoConn = setInterval(() => {
      // this.getUserList();
      // this.checkIfHashIsRegistered("a");
      // }, 1000);
    },

    methods: {
        /**
       * @param {string} hash
       * @return {void}
       */
      checkIfHashIsRegistered(hash) { // this works
        if (this.blockchainIsConnected()) {
          // console.debug(hash);
          window.bc.contract().verifyGraduation.call(hash, (error, bool) => {
            if (error) {
              console.debug(error);
            }
            console.debug(bool);
          })
          // .catch(error => { // mysterious undefuned error
          //   reject(error)
          // });
        }
      }
      /**
       * It reloads the user list.
       */
      // reloadList() {
      //   this.users = [];

      //   this.getUserList();
      // },
      /**
       * Get the list of the registered users once the connection to the
       * blockchain is established.
       */
      // getUserList() {
      //   if (this.blockchainIsConnected()) {
      //     // it shows the loading message
      //     this.isLoading = true;

      //     // stopping the interval
      //     clearInterval(this.tmoConn);

      //     // getting all the users from the blockchain
      //     this.getAllUsers(userProfile => {
      //       this.isLoading = false;
      //       this.users.push(userProfile);
      //     })
      //   }
      // },

      /**
       * Get all users.
       */
      // getAllUsers(callback) {
      //   // getting the total number of users stored in the blockchain
      //   // calling the method totalUsers from the smart contract
      //   window.bc.contract().totalUsers((err, total) => {
      //     var tot = 0;
      //     if (total) tot = total.toNumber();

      //     if (tot > 0) {
      //       // getting the user one by one
      //       for (var i = 1; i <= tot; i++) {
      //         window.bc.contract().getUserById.call(i, (error, userProfile) => {
      //           callback(userProfile);
      //         });
      //       } // end for
      //     } // end if
      //   }); // end totalUsers call
      // },
    } // end methods
  }

</script>

<style>
</style>
