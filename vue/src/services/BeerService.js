import axios from 'axios';

const http = axios.create({
  baseURL: "http://localhost:9000"
});

export default {

  getBeerForBrewery(breweryID) {
    return http.get(`/beer/${breweryID}`)
  },
  addBeer(beer){
    return http.post(`/beer`, beer)
  },
  deleteBeer(beerId){
    return http.delete(`/beer/${beerId}`)
  }
}