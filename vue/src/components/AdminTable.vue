<template>
  <section class="page">
      <table>
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

          </tr>
        </tbody>
      </table>
  </section>
</template>

<script>
import adminService from '../services/AdminService'
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
      }
    },
    created() {
      this.getUnapproved();
    }
}
</script>

<style>

</style>