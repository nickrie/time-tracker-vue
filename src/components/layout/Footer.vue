<template>
  <footer class="bg-light py-3 text-center text-success">
    <p class="mb-0">
      &copy;
      <a href="https://github.com/nickrie">Nick Riemondi</a>
      {{' ' + new Date().getFullYear()}}
    </p>
  </footer>
</template>

<script>
export default {
  name: "Footer"
};
</script>