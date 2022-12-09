<template>
  <div>
    <div id="page-header">
      <img v-bind:src="brewery.imageURL" />
      <div class="brewery-info">
          <h2>{{ brewery.breweryName }}</h2>
          <h3 id="address"><i class="fa-solid fa-location-dot blue"></i> {{ brewery.address }}</h3>
        <h3><i class="fa-solid fa-phone blue"></i> {{ brewery.phoneNumber }}</h3>
        <h3 id="hours"><i class="fa-solid fa-clock blue"></i> {{brewery.hours}}</h3>
        
        <h4><i class="fa-solid fa-star"></i> Avg Rating and # of Reviews here</h4>
      </div>
    </div>
    <div id="page-main">
      <h2>Our History</h2>
      <p>{{ brewery.description }}</p>
    </div>
    <router-link v-show="this.$store.state.user.id===this.$store.state.brewery.owner" class="button" to="/beerForm">Add a beer</router-link>

  </div>
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
  },
  created() {
    this.retrieveBrewery();
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