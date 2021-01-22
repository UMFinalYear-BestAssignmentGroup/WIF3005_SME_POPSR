<template>
  <md-card>
    <md-card-header
      class="card-chart"
      :data-background-color="dataBackgroundColor"
    >
      <canvas class="ct-chart"></canvas>
    </md-card-header>

    <md-card-content>
      <slot name="content"></slot>
    </md-card-content>

    <md-card-actions md-alignment="left">
      <slot name="footer"></slot>
    </md-card-actions>
  </md-card>
</template>

<script>
import Chart from "chart.js";

export default {
  name: "chart",
  props: {
    footerText: {
      type: String,
      default: "",
    },
    headerTitle: {
      type: String,
      default: "Chart title",
    },
    chartType:String,
    chartData:Object,
    chartOptions:Object,
    dataBackgroundColor: {
      type: String,
      default: "",
    },
  },
  methods: {
    createChart(chartType, chartData, chartOptions) {
      const ctx = document.querySelector("canvas");
      const myChart = new Chart(ctx, {
        type: chartType,
        data: chartData,
        options: chartOptions,
      });
    },
  },
  mounted() {
    let {chartType,chartData,chartOptions} = this;
    this.createChart(chartType, chartData, chartOptions);
  },
};
</script>