<template>
  <div id="app">
    <Navbar :formHidden="formHidden" :showForm="showForm"/>
    <AddTask
      v-if="!this.formHidden"
      v-on:add-task="addTask"
      :hideForm="hideForm"
      :validateTaskInputs="validateTaskInputs"
    />
    <Tasks v-bind:tasks="tasks" v-on:delete-task="deleteTask"/>
    <Footer/>
  </div>
</template>

<script>
import Navbar from "./components/layout/Navbar";
import AddTask from "./components/AddTask";
import Tasks from "./components/Tasks";
import Footer from "./components/layout/Footer";

export default {
  name: "app",
  components: {
    Navbar,
    AddTask,
    Tasks,
    Footer
  },

  created() {
    // Get Tasks from LS
    if (window.localStorage.getItem("tasks") === null) {
      this.tasks = [];
    } else {
      this.tasks = JSON.parse(window.localStorage.getItem("tasks"));
    }
  },

  data() {
    return {
      formHidden: false,
      tasks: []
    };
  },

  methods: {
    addTask(task) {
      // Add the task
      this.tasks = [task, ...this.tasks];
      // Update LS
      window.localStorage.setItem("tasks", JSON.stringify(this.tasks));
    },

    deleteTask(id) {
      // Remove the task
      this.tasks = this.tasks.filter(task => task.id != id);
      // Update LS
      window.localStorage.setItem("tasks", JSON.stringify(this.tasks));
    },

    hideForm() {
      this.formHidden = true;
    },

    showForm() {
      this.formHidden = false;
    },

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
