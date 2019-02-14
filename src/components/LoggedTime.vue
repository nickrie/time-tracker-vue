<template>
  <div>{{displayMinutes(minutes + activeMinutes)}}</div>
</template>

<script>
import { displayMinutes } from "./../helpers/display";

export default {
  name: "LoggedTime",
  props: ["minutes", "activeMinutes"],
  methods: {
    displayMinutes
  }
};
</script>