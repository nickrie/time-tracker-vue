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
      <TaskButtons
        v-bind:task="task"
        v-on:edit-task="$emit('edit-task', task.id)"
        v-on:delete-task="$emit('delete-task', task.id)"
      />
    </div>
  </div>
</template>

<script>
import TaskButtons from "./TaskButtons";

export default {
  name: "Task",
  components: {
    TaskButtons
  },
  props: ["task"],
  methods: {
    toggleTask() {
      this.$emit("toggle-task", this.task);
    }
  }
};
</script>

<style scoped>
</style>