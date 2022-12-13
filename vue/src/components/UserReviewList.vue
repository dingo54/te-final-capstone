<template>
<section class="page">
    <div id="page-main">
  <p>{{this.reviews}}</p>
    </div>
</section>
</template>

<script>
import reviewService from "../services/ReviewService";
export default {
    name: "user-review-list",
    data(){
        return {
            reviews: []
        }
    },
    methods: {
        
    },
    created() {
        reviewService.getReviewsForUser(this.$route.params.id).then(response =>{
            this.reviews = response.data;
        })
    }
}
</script>

<style>

</style>