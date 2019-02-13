<template>
  <div class="card bg-light container mt-2">
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
              value
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
                value
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
                value
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
export default {
  name: "AddTask",
  methods: {
    handleSubmit(e) {
      e.preventDefault();
      alert("submit");
    },
    hideForm() {
      alert("hide form");
    }
  }
};
</script>