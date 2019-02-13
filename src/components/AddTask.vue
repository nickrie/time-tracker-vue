<template>
  <div class="container card bg-light mt-2">
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
          <div class="col">
            <button class="btn btn-md-block btn-primary">Add Task</button>
          </div>
          <div class="col text-right">
            <button class="btn btn-secondary" type="button" @click="hideForm">
              <i class="fas fa-arrow-up"/>
            </button>
          </div>
        </div>
      </form>
    </div>
  </div>
</template>

<script>
import uuid from "uuid";

export default {
  name: "AddTask",
  data() {
    return {
      name: "",
      hours: 0,
      minutes: 0
    };
  },
  props: {
    hideForm: { type: Function },
    validateTaskInputs: { type: Function }
  },
  methods: {
    handleSubmit(e) {
      e.preventDefault();

      // Validate the inputs
      const check = this.validateTaskInputs(
        null,
        this.name,
        this.hours,
        this.minutes
      );

      // If there was an error display it and prevent adding the task
      if (check.error) {
        alert(check.msg);
        return;
      }

      // Otherwise build the object to add the task
      let hours = this.hours;
      hours = hours === null || hours === "" ? 0 : parseInt(hours);
      let minutes = this.minutes;
      minutes = minutes === null || minutes === "" ? 0 : parseInt(minutes);
      const logged = parseInt(hours) * 60 + parseInt(minutes);

      const taskAdd = {
        id: uuid.v4(),
        name: this.name,
        logged,
        started: null,
        last: null
      };

      this.$emit("add-task", taskAdd);

      // Clear the form

      this.name = "";
      this.hours = 0;
      this.minutes = 0;
    }
  }
};
</script>