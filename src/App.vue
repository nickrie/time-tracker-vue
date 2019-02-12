<template>
  <div id="app">
    <Tasks v-bind:tasks="tasks" />
  </div>
</template>

<script>
import Tasks from './components/Tasks';

export default {
  name: 'app',
  components: {
    Tasks
  },
  data() {
    return {
      tasks: [
        {
          id: 1,
          name: 'my first task',
          last: null,
          started: null
        },
        {
          id: 2,
          name: 'my second task',
          last: null,
          started: null
        }
      ]
    }
  }
}
</script>

<style>
#app {
}
</style>
