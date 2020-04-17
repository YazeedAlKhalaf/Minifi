<template>
  <div id="app">
    <b-img center alt="Minifi logo" width="250" src="./assets/logo.png" />
    <ShortUrlComponent />
  </div>
</template>

<script>
import ShortUrlComponent from "./components/ShortUrlComponent.vue";

export default {
  name: "App",
  components: {
    ShortUrlComponent
  }
};
</script>

<style>
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}
</style>
