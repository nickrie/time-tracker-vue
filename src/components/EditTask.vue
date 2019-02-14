<template>
  <div class="container card bg-primary text-light mt-2">
    <div class="card-body">
      <form class="ml-auto my-0" @submit="handleSubmit">
        <div class="row">
          <div class="form-group col-md-6 col-lg-8">
            <input
              name="name"
              class="form-control mr-sm-2"
              type="text"
              placeholder="Task Name"
              autocomplete="off"
              v-model="name"
            >
          </div>
          <div class="form-group col-md-3 col-lg-2">
            <div class="input-group">
              <input
                name="hours"
                class="form-control"
                type="number"
                min="0"
                max="999"
                placeholder="Hours"
                autocomplete="off"
                v-model="hours"
              >
              <div class="input-group-append">
                <div class="input-group-text">h</div>
              </div>
            </div>
          </div>
          <div class="form-group col-md-3 col-lg-2">
            <div class="input-group">
              <input
                name="minutes"
                class="form-control"
                type="number"
                min="0"
                max="59"
                placeholder="Minutes"
                autocomplete="off"
                v-model="minutes"
              >
              <div class="input-group-append">
                <div class="input-group-text">m</div>
              </div>
            </div>
          </div>
        </div>

        <div class="row">
          <div
            v-if="this.activeMinutes > 0"
            id="edit-help"
            class="col-md-5 col-lg-4 text-light order-md-2"
          >
            NOTE: This does not include the current active time of
            {{displayMinutes(this.activeMinutes)}}.
          </div>
          <div class="col-md-7 col-lg-8 order-md-1">
            <button
              @click="handleSubmitClick"
              class="btn btn-success mr-1 my-2 my-sm-0"
            >Submit Changes</button>
            <button
              @click="$emit('cancel-edit')"
              type="button"
              class="btn btn-warning mr-1 my-2 my-sm-0"
            >Cancel</button>
            <button
              @click="$emit('delete-task', task.id)"
              class="btn btn-danger mr-1 my-2 my-sm-0"
            >Delete Task</button>
          </div>
        </div>
      </form>
    </div>
  </div>
</template>

<script>
import { displayActiveMinutes, displayMinutes } from "./../helpers/display";

export default {
  name: "EditTask",
  created() {
    // Load task values
    this.$props.tasks.forEach(task => {
      if (task.id == this.$props.editTaskId) {
        this.task = task;
        this.id = task.id;
        this.name = task.name;
        this.hours = Math.floor(task.logged / 60);
        this.minutes = task.logged % 60;
        this.updateTimeValues();
      }
    });
    // Update the activeMinutes value every 5 seconds
    this.refreshTimer = setInterval(this.updateTimeValues, 5000);
  },
  beforeDestroy() {
    clearInterval(this.refreshTimer);
  },
  data() {
    return {
      task: {},
      id: null,
      name: null,
      hours: 0,
      minutes: 0,
      activeMinutes: 0
    };
  },
  props: {
    editTaskId: String,
    tasks: Array,
    validateTaskInputs: { type: Function }
  },
  methods: {
    displayActiveMinutes,
    displayMinutes,
    updateTimeValues() {
      this.activeMinutes = this.displayActiveMinutes(this.task);
    },

    // Prevent the form from submitting on enter
    handleSubmit(e) {
      e.preventDefault();
    },

    // Submit button handler
    handleSubmitClick(e) {
      e.preventDefault();

      let { id, name, hours, minutes } = this;

      // Validate the inputs
      const check = this.validateTaskInputs(id, name, hours, minutes);

      // If there was an error display it and prevent the update
      if (check.error) {
        alert(check.msg);
        return;
      }

      // Otherwise build the object to update firestore

      hours = hours === null || hours === "" ? 0 : parseInt(hours);
      minutes = minutes === null || minutes === "" ? 0 : parseInt(minutes);
      const logged = parseInt(hours) * 60 + parseInt(minutes);

      const taskUpdate = {
        id,
        name,
        logged,
        started: this.task.started,
        last: this.task.last
      };

      this.$emit("update-task", taskUpdate);

      // Clear the form
      this.id = null;
      this.name = null;
      this.hours = 0;
      this.minutes = 0;

      // Update was successful, hide the edit form
      this.$emit("cancel-edit");
    }
  }
};
</script>