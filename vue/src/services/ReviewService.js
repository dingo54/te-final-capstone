import axios from 'axios';

const http = axios.create({
  baseURL: "http://localhost:9000"
});

export default {

    getReviewsForBeer(beerId) {
      return http.get(`/reviews/${beerId}`)
    },
    addReview(review) {
        return http.post('/review', review)
    }
  }