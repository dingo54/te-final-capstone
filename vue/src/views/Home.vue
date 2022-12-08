<template>
  <div class="home">
    <brewer-list/>
    <brewery-list />
    
  </div>
</template>

<script>
import BrewerList from '../components/BrewerList.vue';

import BreweryList from '../components/BreweryList.vue';


export default {
  components: { BreweryList, BrewerList },
  name: "home"
};
</script>
