import axios from 'axios';

const http = axios.create({
  baseURL: "http://localhost:9000"
});

export default {
  
  getUnapprovedBreweries() {
      return http.get('/admin',{headers:{Authorization:'Bearer ' + localStorage.getItem('token')}});
  }
}
