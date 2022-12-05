<template>
  <div>
      <section id="cards">
          <article v-for="brewery in breweries" v-bind:key="brewery.id">
              <h2>{{brewery.breweryName}}</h2>
          </article>
      </section>
  </div>
</template>

<script>
import breweryService from '../services/BreweryService';
export default {
    name: "brewery-list",
    data() {
        return {
            breweries: []
        }
    },
    created() {
        breweryService.getBreweries().then(response => {
            this.breweries = response.data;
        })
    }
}
</script>

<style>

</style>