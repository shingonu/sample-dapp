<template>
  <div id="app">
    <board
      v-bind:message="message"
    ></board>
    <metamask></metamask>
  </div>
</template>

<script>
import Board from './components/Board.vue'
import MetaMask from './components/MetaMask.vue';

import Web3 from 'web3';
import storageABI from './contracts/Storage.json'

export default {
  name: 'app',
  components: {
    'board': Board,
    'metamask': MetaMask,
  },
  data() {
    return {
      message: '',
      web3: null,
      filter: null
    }
  },
  created () {
    // web3 version 0.20.3, https://github.com/ethereum/wiki/wiki/JavaScript-API
    this.web3 = new Web3(new Web3.providers.WebsocketProvider('ws://localhost:8546'));
    
    var storageContract = web3.eth.contract(storageABI);
    var storageContractInstance = storageContract.at('0xd91fb8750ea1decef4cee9d8314f4a60de039457');
    var event = storageContractInstance.Created({}, [])
    
    const self = this;
    event.watch((error, result) => {
      if (!error) console.log(result.args.value);
      self.message = result;
    });
  },
  beforeDestroy () {
    event.stopWatching();
  },
}
</script>

<style>
#app {
  font-family: 'Avenir', Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}
</style>
