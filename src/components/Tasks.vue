<template>
  <div id="task-list" class="container mt-3 mb-5">
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
        v-on:toggle-task="$emit('toggle-task', task)"
        v-on:edit-task="$emit('edit-task', task.id)"
        v-on:delete-task="$emit('delete-task', task.id)"
      />
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
  props: ["tasks", "editTaskId"]
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