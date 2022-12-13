<template>
  <section class="form">
    <form @submit.prevent="addNewReview" class="form-beer">
      <h1>Add Review</h1>
      <!-- <div>
        <label class="sr-only">Name</label>
        <input v-model="beer.name" placeholder="Name" type="text" />
      </div>
      <div>
        <label class="sr-only"> Beer Style</label>
        <input v-model="beer.style" placeholder="Beer Style" type="text" />
      </div>
      <div>
        <label class="sr-only">Price</label>
        <input v-model="beer.price" placeholder="Price" type="text" />
      </div>
      <label class="sr-only"> ABV</label>
      <input v-model="beer.abv" placeholder="ABV" type="text" />
      <div>
        <label class="sr-only">Image URL</label>
        <input v-model="beer.image" placeholder="Image URL" type="text" />
      </div>
      <label class="sr-only">Description</label>
      <input v-model="beer.description" placeholder="Description" type="text" />
      <div>
        <button type="submit" class="button">Submit</button>
        <button v-on:click.prevent="resetForm" class="button">Cancel</button>
      </div> --->
      <!--
      <div>
        <label class="sr-only">Rating:</label>
        <input v-model="review.rating" placeholder="Rating" type="text" />
      </div>
      -->
      <label for="rating">Rating:</label>

        <select name="rating" id="cars"  v-model="review.rating" placeholder="5">
            <option value="1">1</option>
            <option value="2">2</option>
            <option value="3">3</option>
            <option value="4">4</option>
            <option value="5">5</option>
        </select>
      <div>
          <label class="sr-only">Review:</label>
          <input v-model="review.review" placeholder="Type your review here" type="textarea" />
      </div>
      <div>
        <button type="submit" class="button">Submit</button>
        <button v-on:click.prevent="resetForm" class="button">Cancel</button>
      </div>
    </form>
  </section>
</template>

<script>
import ReviewService from "../services/ReviewService";
export default {
    methods:{
    addNewReview() {
      ReviewService.addReview(this.review)
        .then((response) => {
          if (response.status ===201 || response.status===200) {
            this.$router.push(`/beer/${this.$store.state.beer.beerId}`)
          }
        })
        .catch((error) => {
          alert(error.response);
        });
    },
    resetForm() {
      this.$router.push(`/brewery/${this.$store.state.brewery.breweryId}`);
    },
    },
  name: "new-review",
  data() {
    return {
      message: "",
      review: {
        beerId: this.$store.state.beer.beerId,
        username: this.$store.state.user.username,
        userId: this.$store.state.user.id,
        breweryId: this.$store.state.brewery.breweryId,
        rating: 0,
        review: ''
        }
    };
  },
};
</script>

<style>
</style>