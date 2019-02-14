<template>
  <div
    class="row row-task border-top p-2 align-items-center"
    v-bind:class="{
      'bg-success':task.started !== null, 
      'bg-primary text-light':editTaskId === task.id && task.started === null 
    }"
    @click="toggleTask"
  >
    <div class="col col-1"></div>
    <div
      class="col col4"
      v-bind:class="{'bg-primary text-light':editTaskId === task.id}"
    >{{task.name}}</div>
    <div class="col col-2 text-right">
      <LoggedTime v-bind:minutes="task.logged" v-bind:activeMinutes="activeMinutes"/>
    </div>
    <div class="col col-2">
      <LastActive v-bind:active="isActive" v-bind:last="task.last" v-bind:now="nowDate"/>
    </div>
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
import LoggedTime from "./LoggedTime";
import LastActive from "./LastActive";
import TaskButtons from "./TaskButtons";

import { displayActiveMinutes } from "./../helpers/display";

export default {
  name: "Task",
  components: {
    LoggedTime,
    LastActive,
    TaskButtons
  },
  props: ["task", "editTaskId"],
  created() {
    this.activeMinutes = displayActiveMinutes(this.task);
    this.isActive = this.task.started !== null;
    this.nowDate = new Date();
  },
  beforeUpdate() {
    this.activeMinutes = displayActiveMinutes(this.task);
    this.isActive = this.task.started !== null;
    this.nowDate = new Date();
  },
  data() {
    return {
      activeMinutes: 0,
      isActive: false,
      nowDate: new Date()
    };
  },
  methods: {
    toggleTask(e) {
      // Bail if they clicked the edit/delete button/icon
      //  those actions have their own click handlers in TaskButtons
      if (
        e.target.classList.contains("btn-edit") ||
        e.target.classList.contains("fa-pencil-alt") ||
        e.target.classList.contains("btn-delete") ||
        e.target.classList.contains("fa-trash")
      ) {
        return;
      }

      // Otherwise toggle the task
      this.$emit("toggle-task", this.task);
    }
  }
};
</script>

<style scoped>
</style>