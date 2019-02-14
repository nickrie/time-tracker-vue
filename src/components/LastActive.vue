<template>
  <div>
    <span class="d-none d-lg-block">{{long}}</span>
    <span class="d-block d-lg-none">{{short}}</span>
  </div>
</template>

<script>
import moment from "moment";

import { displayMinutes } from "./../helpers/display";

export default {
  name: "LastActive",
  created() {
    this.isActive = this.$props.active;
    this.calc();
  },
  data() {
    return {
      isActive: false,
      long: null,
      short: null
    };
  },
  props: ["active", "last", "now"],
  watch: {
    active: function(newVal) {
      this.isActive = newVal;
      this.calc();
    }
  },
  methods: {
    calc() {
      const { last, now } = this.$props;
      const isActive = this.isActive;

      if (isActive) {
        this.long = "ACTIVE";
        this.short = "ACTIVE";
      } else if (last !== null) {
        // get short elapsed time str
        let a = moment(now);
        let b = moment(last);
        let seconds = a.diff(b, "seconds");
        let minutes = Math.ceil(seconds / 60);
        this.short = displayMinutes(minutes);
        // get long elapsed time str
        this.long = moment(last).from(now);
      }
    }
  }
};
</script>