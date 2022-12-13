<template>
  <section class="page">
    <div id="page-main">
      <h2>Breweries to approve</h2>
      <table v-if="this.breweries.length>0">
        <thead>
          <tr>
            <th>Brewery Name</th>
            <th>Phone Number</th>
            <th>Address</th>
            <th>Hours</th>
            <th>Owner</th>
            <th>Approve</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="brewery in breweries" v-bind:key="brewery.breweryId">
            <td>{{brewery.breweryName}}</td>
            <td>{{brewery.phoneNumber}}</td>
            <td>{{brewery.address}}</td>
            <td>{{brewery.hours}}</td>
            <td>{{brewery.owner}}</td>
            <td><button class="button" v-on:click="approveBrewery(brewery)">Approve</button></td>
          </tr>
        </tbody>
      </table>
      <p v-if="this.breweries.length===0">There are no breweries to approve.</p>
    </div>
  </section>
</template>

<script>
import adminService from '../services/AdminService';
import breweryService from "../services/BreweryService";
export default {
    name: "admin-table",
    data() {
      return {
        breweries: []
      }
    },
    methods: {
      getUnapproved() {
        adminService.getUnapprovedBreweries().then(response =>{
        this.breweries = response.data;
      });
      },
      approveBrewery(brewery) {
        brewery.isApproved = true;
        breweryService.updateBrewery(brewery.breweryId,brewery).then(response => {
          if(response.status==201 || response.status==200){
            this.getUnapproved();
          }
        });
      }
    },
    created() {
      this.getUnapproved();
    }
}
</script>

<style>

</style>