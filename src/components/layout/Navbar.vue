<template>
  <nav class="navbar sticky-top navbar-expand-md navbar-dark bg-primary">
    <div class="container">
      <a href="#!" class="navbar-brand">
        <i class="fas fa-tasks pr-3"/>
        Time Tracker v3
      </a>
      <div class="nav-links">
        <a href="https://github.com/nickrie" class="text-light ml-2">
          <i class="fab fa-github fa-2x"/>
        </a>
        <a v-if="formHidden" href="#!" @click="showForm" class="text-light ml-3">
          <i class="fas fa-arrow-down fa-2x"/>
        </a>
      </div>
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