<template>
  <div id="page-main">
    <h2>Our Beers</h2>
    <article v-for="beer in beers" v-bind:key="beer.beerId" class="beer">
      <div class="beer-info">
        <h3>{{ beer.name }}</h3>
        <h4>{{ beer.style }}</h4>
        <h4>ABV: {{ beer.abv }}</h4>
        <h4>${{ beer.price }}</h4>
        <p>{{ beer.description }}</p>
      </div>
      <div class="beer-image-container">
        <img v-bind:src="beer.image" v-if="beer.image !== null" />
        <img src="../assets/mug.png" v-if="beer.image === null" />
      </div>
    </article>
  </div>
</template>

<script>
import beerService from "../services/BeerService";
export default {
  name: "beer-list",
  data() {
    return {
      beers: [],
    };
  },
  created() {
    beerService.getBeerForBrewery(this.$route.params.id).then((response) => {
      this.beers = response.data;
    });
  },
};
</script>

<style>
</style>