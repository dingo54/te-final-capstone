<template>
  <div>
    <section id="cards">
      <article v-for="brewery in breweries" v-bind:key="brewery.id">
        <div class="info">
          <h2>{{ brewery.breweryName }}</h2>
          <p>{{ brewery.address }}</p>
          <p>{{ brewery.phoneNumber }}</p>
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
  created() {
    breweryService.getBreweries().then((response) => {
      this.breweries = response.data;
    });
  },
};
</script>

<style>
.brewery-image {
  width: 100%;
  position: relative;
  z-index: 1;
}
.info {
    position: absolute;
    z-index: 2;
    padding: 5px;
    background-color: rgba(255,255,255,0.7);
    width: 100%;
}
.info h2 {

}
</style>