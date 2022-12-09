<template>
  <section class="form">
    <form class="form-beer">
        <h1>Add a New Beer</h1>
      <div>
        <label class="sr-only">Name</label>
        <input placeholder="Name" type="text" />
      </div>
      <div>
        <label class="sr-only"> Beer Style</label>
        <input placeholder="Beer Style" type="text" />
      </div>
      <div>
        <label class="sr-only" >Price</label>
        <input placeholder="Price" type="text" />
      </div>
      <label class="sr-only"> ABV</label>
      <input placeholder="ABV" type="text" />
      <div>
        <label class="sr-only">Image URL</label>
        <input placeholder="Image URL" type="text" />
      </div>
      <label class="sr-only">Description</label>
      <input placeholder="Description" type="text" />
      <div>
        <button class="button">Submit</button>
        <button class="button">Cancel</button>
      </div>
    </form>
  </section>
</template>

<script>
export default {
  name: "new-beer",
};
</script>

<style>
</style>