<template>
  <div class="home">
    <brewery-list />
  </div>
</template>

<script>
import BreweryList from '../components/BreweryList.vue';
export default {
  components: { BreweryList },
  name: "home"
};
</script>
