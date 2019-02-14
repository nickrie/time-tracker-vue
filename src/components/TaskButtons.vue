<template>
  <div>
    <div class="d-none d-md-block">
      <button
        type="button"
        @click="$emit('edit-task', task.id)"
        class="btn btn-outline-dark btn-edit"
        :disabled="disabled"
        style="margin-right: 2px;"
      >
        <i class="fas fa-pencil-alt"/>
      </button>
      <button
        type="button"
        @click="$emit('delete-task', task.id)"
        class="btn btn-outline-dark btn-delete"
        :disabled="disabled"
      >
        <i class="fas fa-trash"/>
      </button>
    </div>
    <div class="d-block d-md-none">
      <button
        type="button"
        @click="$emit('edit-task', task.id)"
        class="btn btn-outline-dark btn-edit"
        :disabled="disabled"
      >
        <i class="fas fa-pencil-alt"/>
      </button>
    </div>
  </div>
</template>

<script>
export default {
  name: "TaskButtons",
  props: ["task", "disabled"]
};
</script>