<template>
  <div id="app">
    <Navbar :formHidden="formHidden" :showForm="showForm"/>
    <AddTask
      v-if="!this.formHidden && !this.editTaskId"
      v-on:add-task="addTask"
      :hideForm="hideForm"
      :validateTaskInputs="validateTaskInputs"
    />
    <EditTask
      v-if="!this.formHidden && this.editTaskId"
      v-bind:tasks="tasks"
      v-bind:editTaskId="editTaskId"
      v-on:cancel-edit="cancelEdit"
      v-on:update-task="updateTask"
      v-on:delete-task="deleteTask"
      :validateTaskInputs="validateTaskInputs"
    />
    <Tasks
      v-bind:tasks="tasks"
      v-bind:editTaskId="editTaskId"
      v-bind:startedTaskId="startedTaskId"
      v-bind:stoppedTaskId="stoppedTaskId"
      v-on:toggle-task="toggleTask"
      v-on:edit-task="editTask"
      v-on:delete-task="deleteTask"
    />
    <Footer/>
  </div>
</template>

<script>
import Navbar from "./components/layout/Navbar";
import AddTask from "./components/AddTask";
import EditTask from "./components/EditTask";
import Tasks from "./components/Tasks";
import Footer from "./components/layout/Footer";

import Moment from "moment";

export default {
  name: "app",
  components: {
    Navbar,
    AddTask,
    EditTask,
    Tasks,
    Footer
  },

  created() {
    // Get Tasks from LS
    if (window.localStorage.getItem("tasks-v3") === null) {
      this.tasks = [];
    } else {
      this.tasks = JSON.parse(window.localStorage.getItem("tasks-v3"));
    }
  },

  data() {
    return {
      formHidden: false,
      editTaskId: null,
      startedTaskId: null,
      stoppedTaskId: null,
      tasks: []
    };
  },

  methods: {
    // Hide the add/edit form
    hideForm() {
      this.formHidden = true;
    },

    // Show the add/edit form
    showForm() {
      this.formHidden = false;
    },

    // Edit a task
    editTask(taskId) {
      this.showForm();
      this.editTaskId = taskId;
    },

    // Cancel the edit form
    cancelEdit() {
      this.editTaskId = null;
    },

    // Add a task
    addTask(task) {
      // Add the task
      this.tasks = [task, ...this.tasks];
      // Update LS
      window.localStorage.setItem("tasks-v3", JSON.stringify(this.tasks));
      // Start the task
      this.toggleTask(task);
    },

    // Update a task
    updateTask(task) {
      // Find the index of this task
      let idx = -1;
      this.tasks.forEach((compareTask, compareIdx) => {
        if (task.id === compareTask.id) {
          idx = compareIdx;
        }
      });
      if (idx !== -1) {
        // Update the taskId
        this.tasks = [
          ...this.tasks.slice(0, idx),
          task,
          ...this.tasks.slice(idx + 1)
        ];
        // Update LS
        window.localStorage.setItem("tasks-v3", JSON.stringify(this.tasks));
      }
    },

    // Delete a task
    deleteTask(id) {
      if (window.confirm("Are you sure you want to delete this task?")) {
        // Remove the task
        this.tasks = this.tasks.filter(task => task.id != id);
        // Update LS
        window.localStorage.setItem("tasks-v3", JSON.stringify(this.tasks));
        // If we deleted from the Edit Form, hide it
        this.cancelEdit();
      }
    },

    // Toggle a task
    toggleTask(task) {
      if (task.started === null) {
        this.startTask(task);
      } else {
        this.stopRunningTasks();
      }
    },

    // Start a task timer
    startTask(task) {
      // Stop any running tasks first
      this.stopRunningTasks();

      // Build the update object
      const started = new Date();
      const taskUpdate = {
        id: task.id,
        name: task.name,
        logged: task.logged,
        started,
        last: task.last
      };

      // Update the task
      this.updateTask(taskUpdate);

      // Mark this task id as started for the action icon
      this.startedTaskId = task.id;
      // Clear startedTaskId after one second
      setTimeout(() => {
        this.startedTaskId = null;
      }, 1000);

      return false;
    },

    // Stop all running task timers
    //  NOTE: although the app limits one running app at a time,
    //    since the user is free to edit LocalStorage assume more 
    //    than one could be running.
    stopRunningTasks() {
      let started, taskUpdate;

      this.tasks.forEach(task => {
        if (task.started !== null) {
          // Stop the task
          started = null;

          // Calculate new logged time
          //  Don't update logged time or last date if it was active for less than 5 seconds
          const a = Moment(new Date());
          const b = Moment(task.started);
          const seconds = a.diff(b, "seconds");
          const minutes = seconds < 5 ? 0 : Math.ceil(seconds / 60);

          if (minutes > 0) {
            // Time was logged, stop the task and update logged time and last started
            const logged = parseInt(task.logged) + minutes;
            const last = new Date();
            taskUpdate = {
              id: task.id,
              name: task.name,
              logged,
              started,
              last
            };
          } else {
            // No time was logged, so just stop the task
            taskUpdate = {
              id: task.id,
              name: task.name,
              logged: task.logged,
              started,
              last: task.last
            };
          }

          // Update the task
          this.updateTask(taskUpdate);

          // Mark this task id as stopped for the action icon
          this.stoppedTaskId = task.id;
          // Clear startedTaskId after one second
          setTimeout(() => {
            this.stoppedTaskId = null;
          }, 1000);
        }
      });
    },

    // Validate task form input values
    validateTaskInputs(id, name, hours, minutes) {
      // Ensure name is not empty
      if (name.trim() === "") {
        return {
          error: true,
          focus: "name",
          msg: "NAME is required."
        };
      }

      // Ensure another task with that name doesn't already exist
      let nameExists = false;
      this.tasks.forEach(task => {
        if (task.name === name && task.id !== id) {
          nameExists = true;
        }
      });
      if (nameExists === true) {
        return {
          error: true,
          focus: "name",
          msg: "A task already exists with that name."
        };
      }

      // Check hours and minutes to ensure they are integer values of the expected size
      hours = hours === null || hours === "" ? 0 : parseInt(hours);
      minutes = minutes === null || minutes === "" ? 0 : parseInt(minutes);
      if (hours < 0 || minutes < 0 || isNaN(hours) || isNaN(minutes)) {
        return {
          error: true,
          focus: "hours",
          msg: "Hours and minutes must be positive integer values."
        };
      }

      // Ensure minutes value is valid
      if (minutes >= 60) {
        return {
          error: true,
          focus: "minutes",
          msg: "Minutes must be under 60."
        };
      }

      // Ensure a reasonable upper limit on hours
      if (hours >= 1000) {
        return {
          error: true,
          focus: "minutes",
          msg: "Hours should not exceed 1000."
        };
      }

      return { error: false };
    }
  }
};
</script>

<style>
#app {
}

body {
  min-height: 100vh;
  position: relative;
  margin: 0;
  padding-bottom: 30px;
}

footer {
  position: absolute;
  bottom: 0;
  width: 100vw;
}
</style>
