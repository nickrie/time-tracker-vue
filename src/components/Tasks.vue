<template>
  <div>
    <div v-bind:key="task.id" v-for="task in tasks">{{task.name}}</div>
  </div>
</template>

<script>
export default {
  name: "Tasks",
  props: ["tasks"]
};
</script>

<style scoped>
</style>