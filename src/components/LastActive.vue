<template>
  <div>
    <span class="d-none d-lg-block">{{getLong()}}</span>
    <span class="d-block d-lg-none">{{getShort()}}</span>
  </div>
</template>

<script>
import moment from "moment";

import { displayMinutes } from "./../helpers/display";

export default {
  name: "LastActive",
  props: ["isActive", "last", "now"],
  methods: {
    getLong() {
      const { isActive, last, now } = this.$props;

      if (isActive) {
        return "ACTIVE";
      } else if (last !== null) {
        return moment(last).from(now);
      }
    },
    getShort() {
      const { isActive, last, now } = this.$props;

      if (isActive) {
        return "ACTIVE";
      } else if (last !== null) {
        let a = moment(now);
        let b = moment(last);
        let seconds = a.diff(b, "seconds");
        let minutes = Math.ceil(seconds / 60);
        return displayMinutes(minutes);
      }
    }
  }
};
</script>