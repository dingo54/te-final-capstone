<template>
  <div class="home">
    <brewer-list v-if="this.role==brewer"/>
    <brewery-list v-if="this.$store.state.token=='' || role==user"/>
    <admin-table v-if="this.role==this.admin" />
  </div>
</template>

<script>
import AdminTable from '../components/AdminTable.vue';
import BrewerList from '../components/BrewerList.vue';

import BreweryList from '../components/BreweryList.vue';


export default {
  components: { BreweryList, BrewerList, AdminTable },
  name: "home",
  data(){
    return{
      role: this.$store.state.user.authorities[0].name,
      user: 'ROLE_USER',
      brewer: 'ROLE_BREWER',
      admin: 'ROLE_ADMIN'
    }
  }
};
</script>
