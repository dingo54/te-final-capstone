import axios from 'axios';

const http = axios.create({
  baseURL: "http://localhost:9000"
});

export default {

    register(user) {
    return http.post('/register', user)
  },

  getBreweries() {
    return http.get('/brewery')
  },

  getBrewery(breweryID) {
    return http.get(`/brewery/${breweryID}`)
  },

  getBeerForBrewery(breweryID) {
    return http.get(`/beer/${breweryID}`)
  }

}
