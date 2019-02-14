<template>
  <div>
    <div v-if="tasks.length" id="task-list" class="container mt-3 mb-5">
      <div class="row text-secondary" id="row-header">
        <div class="col col-1"></div>
        <div class="col col-4">
          <h5>Task Name</h5>
        </div>
        <div class="col col-3 text-right">
          <h5>
            <span class="d-none d-lg-inline">Time</span>Logged
          </h5>
        </div>
        <div class="col col-2">
          <h5>
            Last
            <span class="d-none d-lg-inline">Active</span>
          </h5>
        </div>
        <div class="col col-2"></div>
      </div>
      <div v-bind:key="task.id" v-for="task in tasks">
        <Task
          v-bind:task="task"
          v-bind:editTaskId="editTaskId"
          v-bind:startedTaskId="startedTaskId"
          v-bind:stoppedTaskId="stoppedTaskId"
          v-on:toggle-task="$emit('toggle-task', task)"
          v-on:edit-task="$emit('edit-task', task.id)"
          v-on:delete-task="$emit('delete-task', task.id)"
        />
      </div>
    </div>
    <div v-if="!tasks.length" class="container text-center text-secondary my-5">
      <h1 class="display-4">Your task list is empty.</h1>
      <p class="lead">Add a task above to get started!</p>
      <p class="text-success">New tasks are started automatically.</p>
      <p class="text-warning">Click a task to start/stop the timer.</p>
      <p class="text-secondary">
        Times are always rounded up to the nearest minute.
        <br>A task must be active for at least 5 seconds for time to be
        logged.
      </p>
    </div>
  </div>
</template>

<script>
import Task from "./Task";

export default {
  name: "Tasks",
  components: {
    Task
  },
  props: ["tasks", "editTaskId", "startedTaskId", "stoppedTaskId"]
};
</script>

<style>
.fa-stop {
  color: red;
}
.fa-play {
  color: #18bc9c;
}

/* 
  hover actions should not occur on touch devices
  in order to prevent having to double click on mobile 
  to click buttons or start/stop a task 
*/

.hover-icon {
  display: none;
}

@media (pointer: fine) {
  #task-list .row-task:hover {
    background-color: #eee;
  }
  #task-list .row-task .hover-icon {
    display: none;
  }
  #task-list .row-task:hover .hover-icon {
    display: block;
  }

  .btn-edit:hover:enabled {
    color: blue;
  }

  .btn-delete:hover:enabled {
    color: red;
  }
}
</style>