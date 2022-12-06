<template>
  <section class="page">
    <div id="page-header">
      <img v-bind:src="brewery.imageURL" />
      <div class="brewery-info">
          <h2>{{ brewery.breweryName }}</h2>
        <h3><i class="fa-solid fa-phone blue"></i> {{ brewery.phoneNumber }}</h3>
        <h3 id="address"><i class="fa-solid fa-location-dot blue"></i> {{ brewery.address }}</h3>
        
        <h4><i class="fa-solid fa-star"></i> Avg Rating and Reviews here</h4>
      </div>
    </div>
    <div id="page-main">
      <h3>Our History</h3>
      <p>{{ brewery.description }}</p>
      <h3>Our Beers</h3>
      <p>{{beers}}</p>
      <article
        v-for="beer in beers"
        v-bind:key="beer.beerId"
      >
        <h3>{{this.beer.name}}</h3>
      </article>
    </div>
    
  </section>
</template>

<script>
import breweryService from "../services/BreweryService";

export default {
  name: "brewery-detail",
  data() {
    return {
      errorMsg: "",
      beers: []
    };
  },
  methods: {
    retrieveBrewery() {
      breweryService
        .getBrewery(this.$route.params.id)
        .then(response => {
          this.$store.commit("SET_CURRENT_BREWERY", response.data);
        })
        .catch(error => {
          if (error.response && error.response.status === 404) {
            alert(
              "Brewery not available. It may have been deleted or you have entered an invalid brewery ID."
            );
          }
        });
    },
  },
  created() {
    this.retrieveBrewery();
    breweryService
      .getBeerForBrewery(this.$route.params.id)
      .then(response => {
        this.beers = response.data;
      });
  },
  computed: {
    brewery() {
      return this.$store.state.brewery;
    },
  },
};
</script>

<style>

</style>