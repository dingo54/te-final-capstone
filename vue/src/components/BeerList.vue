<template>
  <div id="page-main">
      <h2>Our Beers</h2>
      <article v-for="beer in beers" v-bind:key="beer.beerId" class="beer">
          <div class="beer-info">
              <h3>{{beer.name}}</h3>
          <h4>{{beer.style}}</h4>
          <h4>ABV: {{beer.abv}}</h4>
          <h4>${{beer.price}}</h4>
          <p>{{beer.description}}</p>
          </div>
          <img v-bind:src="beer.image" />
      </article>
  </div>
</template>

<script>
import breweryService from "../services/BreweryService";
export default {
    name: "beer-list",
    data() {
        return {
            beers: []
        }
    },
    created() {
        breweryService
            .getBeerForBrewery(this.$route.params.id)
            .then(response => {
                this.beers = response.data;
            })
    }
}
</script>

<style>

</style>