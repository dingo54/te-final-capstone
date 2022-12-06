<template>
  <section class="page">
      <h2>{{this.$store.state.brewery}}</h2>
      <p>Testing</p>
  </section>
</template>

<script>
  import breweryService from "../services/BreweryService";

export default {
  name: "brewery-detail",
  data() {
    return {
      errorMsg: ""
    }
  },
  methods: {
    retrieveBrewery() {
      breweryService
        .getBrewery(this.$route.params.breweryID)
        .then(response => {
          this.$store.commit("SET_CURRENT_BREWERY", response.data);
        })
        .catch(error => {
          if (error.response && error.response.status === 404) {
            alert(
              "Brewery not available. This card may have been deleted or you have entered an invalid brewery ID."
            );
            this.$router.push({ name: 'Home' });
          }
        })
    }
  },
  created() {
    this.retrieveBrewery();
  }
}
</script>

<style>

</style>