<template>
  <div>
    <section class="beerHeader">
      <h2>Reviews</h2>
      <!-- <router-link to="/beerForm" v-show="brewerStatus === true" class="button">Add a beer</router-link> -->
      <router-link to="/reviewForm" v-show="loggedIn === true && brewerStatus===false" class="button">Add Review</router-link>
    </section>
    <div v-for="review in reviews" v-bind:key="review.reviewId" class="review">
      <article>
        <div class="review-info">
          <!-- <h3 v-on:click="viewBeerDetail(beer.beerId)" v-bind:beer="beer"> {{ review.user }} </h3> -->
          <h4>{{ review.username }}</h4>
          <h4>Rating: {{ review.rating }}/5</h4>
          <p>{{ review.review }}</p>
        </div>
      </article> 
      <!-- <div class="brewer-btns" v-show="userStatus === true"> -->
        <!-- <button v-on:click="updateBeer(beer)" class="button">Update Beer</button> -->
        <!-- <button v-on:click="deleteBeer(beer.beerId)" class="button">Delete Beer</button> -->
        <!-- <button v-on:click="addReview(beer)" class="button">Add Review</button> -->
      <!-- </div> -->
      
    </div>
  </div>
</template>

<script>
import reviewService from "../services/ReviewService";
export default {
  name: "review-list",
  methods: {
    //deleteBeer(beerId){
    //  beerService.deleteBeer(beerId).then(response=>{
    //    if(response.status===200||response.status===201){
    //  this.getBeers();
    //    }
    //  });
    //},
    //updateBeer(beer) {
    //  this.$store.state.beer = beer;
    //  this.$router.push("/updateBeerForm");
    //},
    getReviews() {
      reviewService
        .getReviewsForBeer(this.$route.params.id)
        .then((response) => {
          this.reviews = response.data;
          this.loggedIn = this.isLoggedIn();
          this.brewerStatus = this.isBrewer()
        });
    },
    isLoggedIn() {
      if (this.$store.state.token != '') {
        this.loggedIn = "loggedIn";
       return true;
      } else {
        this.loggedIn = "notLoggedIn";
        return false;
      }
    },
    isBrewer() {
      if(this.$store.state.user.id===this.$store.state.brewery.owner){
        this.brewerStatus = "Brewer"
        return true;
      } else {
        this.brewerStatus = "Not a Brewer"
        return false;
      }
    },    
    //viewBeerDetail(beerId) {
    //  this.$router.push(`/beer/${beerId}`);
    //},
  },
  data() {
    return {
      reviews: [],
      loggedIn: false,
      brewerStatus: false
    };
  },
  created() {
    this.getReviews();
  },
};
</script>

<style>
</style>