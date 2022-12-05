import axios from 'axios';

const http = axios.create({
  baseURL: "http://localhost:9000"
});

export default {

  getBreweries() {
    return http.get('/brewery')
  },

  register(user) {
    return http.post('/register', user)
  }

}
