<template>
  <div id="app">
    <Navbar/>
    <AddTask />
    <Tasks v-bind:tasks="tasks" v-on:delete-task="deleteTask"/>
    <Footer/>
  </div>
</template>

<script>
import Navbar from "./components/layout/Navbar";
import AddTask from './components/AddTask';
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
  data() {
    return {
      tasks: [
        {
          id: 1,
          name: "my first task",
          logged: "15m",
          last: "1h 15m",
          started: null
        },
        {
          id: 2,
          name: "my second task",
          logged: null,
          last: null,
          started: new Date()
        },
        {
          id: 3,
          name: "my third task",
          logged: "1h 30m",
          last: "20h 10m",
          started: null
        }
      ]
    };
  },
  methods: {
    deleteTask(id) {
      alert("delete " + id);
      this.tasks = this.tasks.filter(task => task.id != id);
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
