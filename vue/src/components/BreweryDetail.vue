<template>
  <section class="page">
    <div id="page-header">
      <img v-bind:src="brewery.imageURL" />
      <div class="brewery-info">
        <h2>{{ brewery.breweryName }}</h2>
        <h3><i class="fa-solid fa-phone"></i> {{ brewery.phoneNumber }}</h3>
        <h3><i class="fa-solid fa-location-dot"></i> {{ brewery.address }}</h3>
        <h4>Avg Rating and Reviews here</h4>
      </div>
    </div>
    <div id="page-main">
      <h3>Our History</h3>
      <p>{{ brewery.description }}</p>
      <h3>Beer List Here</h3>
      <p>{{beers.length}}</p>
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
    retrieveBeers() {
      breweryService
        .getBeerForBrewery(this.$route.params.id)
        .then(response => {
          this.$Store.commit("SET_CURRENT_BEERS", response.data);
        })
        .catch(error => {
          if (error.response && error.response.status === 404) {
            alert(
              "Brewery not available. It may have been deleted or you have entered an invalid brewery ID."
            );
          }
        });
    }
  },
  created() {
    this.retrieveBrewery();
    this.retrieveBeers();
  },
  computed: {
    brewery() {
      return this.$store.state.brewery;
    },
    beers() {
      return this.$store.state.beers;
    }
  },
};
</script>

<style>
#page-header {
  height: 400px;
  overflow: hidden;
}
.brewery-info {
  position: absolute;
  top: 0;
  z-index: 2;
  background-color: rgba(0, 0, 0, 0.7);
  color: white;
  padding: 20px;
  height: 360px;
  font-family: Montserrat, sans-serif;
  font-size: 20px;
}
.brewery-info h2 {
  font-size: 30px;
}
.brewery-info h3 {
  margin-top: 10px;
  font-size: 30px;
}
</style>