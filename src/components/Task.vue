<template>
  <div
    class="row row-task border-top p-2 align-items-center"
    v-bind:class="{'bg-primary text-light':task.started !== null}"
    @click="toggleTask"
  >
    <div class="col col-1"></div>
    <div class="col col4">{{task.name}}</div>
    <div class="col col-2 text-right">{{task.logged}}</div>
    <div class="col col-2">{{task.last}}</div>
    <div class="col col-2">
      <button
        type="button"
        class="btn btn-outline-dark btn-delete"
        @click="$emit('delete-task', task.id)"
      >
        <i class="fas fa-trash"/>
      </button>
    </div>
  </div>
</template>

<script>
export default {
  name: "Task",
  props: ["task"],
  methods: {
    toggleTask() {
      this.task.started = this.task.started === null ? new Date() : null;
    }
  }
};
</script>

<style scoped>
</style>