<template>
  <nav class="navbar sticky-top navbar-expand-md navbar-dark bg-primary">
    <div class="container">
      <a href="#!" class="navbar-brand">
        <i class="fas fa-tasks pr-3"/>
        Time Tracker v3
      </a>
      <a href="https://github.com/nickrie" class="text-light ml-2">
        <i class="fab fa-github fa-2x"/>
      </a>
    </div>
    <div v-if="formHidden" class="ml-3">
      <a href="#!" @click="showForm" class="text-light">
        <i class="fas fa-arrow-down fa-2x"/>
      </a>
    </div>
  </nav>
</template>

<script>
export default {
  name: "Navbar",
  props: {
    formHidden: Boolean,
    showForm: { type: Function }
  }
};
</script>