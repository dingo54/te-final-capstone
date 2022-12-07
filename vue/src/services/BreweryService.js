import axios from 'axios';

const http = axios.create({
  baseURL: "http://localhost:9000"
});

export default {

  getBreweries() {
    return http.get('/brewery')
  },

  getBrewery(breweryID) {
    return http.get(`/brewery/${breweryID}`)
  }

}
