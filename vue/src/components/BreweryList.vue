<template>
  <div>
    <section id="cards">
      <article 
        v-for="brewery in breweries" 
        v-bind:key="brewery.breweryId"
        v-on:click="viewBreweryDetail(brewery.breweryId)"
      >
        <div class="info">
          <h2>{{ brewery.breweryName }}</h2>
          <p>{{ brewery.address }}</p>
          <p style="flex-grow:1;">{{ brewery.phoneNumber }}</p>
          <p><i class="fa-solid fa-star"></i>Avg Rating and Reviews here</p>
        </div>
        <img v-bind:src="brewery.imageURL" class="brewery-image" />
      </article>
    </section>
  </div>
</template>

<script>
import breweryService from "../services/BreweryService";
export default {
  name: "brewery-list",
  data() {
    return {
      breweries: [],
    };
  },
  methods: {
    viewBreweryDetail(breweryID) {
      this.$router.push(`/brewery/${breweryID}`)
    }
  },
  created() {
    breweryService.getBreweries().then((response) => {
      this.breweries = response.data;
    });
  },
};
</script>

<style>

</style>