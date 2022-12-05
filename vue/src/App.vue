<template>
  <div id="app">
    <header>
      <nav>
        <div>
          <router-link v-bind:to="{ name: 'home' }">Home</router-link>&nbsp;|&nbsp;
        </div>
        <div>
          <router-link v-bind:to="{ name: 'logout' }" v-if="$store.state.token != ''">Logout</router-link>
          <router-link v-bind:to="{name: 'login' }" v-if="$store.state.token == ''">Login</router-link>
          <span v-if="$store.state.token == ''">&nbsp;|&nbsp;</span>
          <router-link v-bind:to="{name: 'register' }" v-if="$store.state.token == ''">Register</router-link>
        </div>
      </nav>
    <h1><router-link v-bind:to="{ name: 'home' }">Brewery Finder</router-link></h1>
    </header>
    <main>
      <router-view />
    </main>
    
  </div>
</template>

<style>
*{
    padding: 0;
    margin: 0;
}
body {
    background-color: rgba(0,0,0,1);
}
header {
    background-image: linear-gradient(to top, rgba(0,0,0,1), rgba(0,0,0,0) 30%), url("assets/banner-cropped.jpg");
  background-repeat: no-repeat;
  background-size: cover;
  height: 400px;
  position: relative;
}
header h1 {
    text-align: center;
    line-height: 300px;
    font-size: 10vw;
}
header h1 a {
    color: white;
    text-decoration: none;
}
nav {
    display: flex;
    justify-content: space-between;
    color: white;
    padding: 20px;
}

nav div {
    display: flex;
    justify-content: center;
    gap: 5px;
}

nav a,
nav label,
#sort-options a {
    color: white;
}
main {
    margin-top: -70px;
    position: relative;
    z-index: 1;
}
#sort-options {
    display: flex;
    justify-content: flex-start;
    gap: 5px;
    color: white;
    margin: 0 50px;
}
main #cards {
    display: flex;
    justify-content: center;
    flex-wrap: wrap;
}
article {
    background-color: white;
    display: block;
    margin: 10px;
    padding: 10px;
    width: 400px;
    height: 200px;
    box-shadow: 0 3px 6px rgba(0,0,0,0.16), 0 3px 6px rgba(0,0,0,0.23);
}

.page {
    max-width: 900px;
    margin: 0 auto;
    background-color: white;
    padding: 10px 20px;
    box-shadow: 0 3px 6px rgba(0,0,0,0.16), 0 3px 6px rgba(0,0,0,0.23);
}
.page .header {
    display: flex;
    justify-content: space-around;
}
.page hr {
    margin: 10px 0;
    border: 2px solid black;
    border-radius: 10px;
}
.page p {
    margin: 15px 0;
}
.login {
  max-width: 400px;
  margin: 0 auto;
  padding: 25px;
  border-radius: 20px;
  background-color: white;
  box-shadow: 0 3px 6px rgba(0,0,0,0.16), 0 3px 6px rgba(0,0,0,0.23);
}
.form-signin,
.form-register {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 10px;
}
.login h1 {
  text-align: center;
  font-size: 40px;
}
.alert {
  margin: 5px 0;
  padding: 5px;
  border-radius: 5px;
}
.alert-danger {
  background-color: red;
  color: white;
}
.alert-success {
  background-color: green;
  color: white;
}
.button {
  font-size: 15px;
  padding: 10px;
  border-radius: 5px;
  font-weight: bold;
  border: none;
  cursor: pointer;
}
.green {
  background-color: green;
  color: white;
}
.blue {
  background-color: blue;
  color: white;
}
@media screen and (max-width: 900px) {
    article {
        width: 90%;
    }
}
</style>
