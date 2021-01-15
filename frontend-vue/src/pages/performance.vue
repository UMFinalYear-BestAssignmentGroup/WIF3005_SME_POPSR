<template>
  <div class="content">
    <div class="md-layout">
      <div
        class="md-layout-item md-medium-size-90 md-xsmall-size-90 md-size-90"
      >
        <table cls="clsForm" width="80%:">
          <col width="15%" />
          <col width="70%" />
          <tr>
            <td class="clsLabel">
              Year:
            </td>
            <td class="clsValue">
              <b-input v-model="year" style="width: 98%"></b-input>
              <div class="error" v-if="!$v.year.required && isPosted">
                Year is required
              </div>
            </td>
            <td>
              <md-button
                class="md-raised md-success"
                @click="filter_year()"
                style="margin: auto; display: block"
                >Filter</md-button
              >
            </td>
          </tr>
        </table>
      </div>
      <div
        class="md-layout-item md-medium-size-50 md-xsmall-size-100 md-size-25"
      >
        <stats-card data-background-color="green">
          <template slot="header">
            <md-icon>text_snippet</md-icon>
          </template>

          <template slot="content">
            <p class="category">Total Number of PO</p>
            <h3 class="title">{{ totalPO }}</h3>
          </template>

          <template slot="footer">
            <div class="stats">
              <md-icon>date_range</md-icon>
              {{ new Date().getFullYear() }}
            </div>
          </template>
        </stats-card>
      </div>
      <div
        class="md-layout-item md-medium-size-50 md-xsmall-size-100 md-size-25"
      >
        <stats-card data-background-color="orange">
          <template slot="header">
            <md-icon>content_copy</md-icon>
          </template>

          <template slot="content">
            <p class="category">Efficiency for PO Approval</p>
            <h3 class="title">{{ efficiency }}</h3>
          </template>

          <template slot="footer">
            <div class="stats">
              <md-icon>date_range</md-icon>
              {{ new Date().getFullYear() }}
            </div>
          </template>
        </stats-card>
      </div>
      <div
        class="md-layout-item md-medium-size-50 md-xsmall-size-100 md-size-25"
      >
        <stats-card data-background-color="purple">
          <template slot="header">
            <md-icon>article</md-icon>
          </template>

          <template slot="content">
            <p class="category">Approved PO</p>
            <h3 class="title">{{ totalPO - totalDeclinePO }}</h3>
          </template>

          <template slot="footer">
            <div class="stats">
              <md-icon>date_range</md-icon>
              {{ new Date().getFullYear() }}
            </div>
          </template>
        </stats-card>
      </div>
      <div
        class="md-layout-item md-medium-size-50 md-xsmall-size-100 md-size-25"
      >
        <stats-card data-background-color="red">
          <template slot="header">
            <i class="fas fa-file-invoice"></i>
          </template>

          <template slot="content">
            <p class="category">Rejected PO</p>
            <h3 class="title">{{ totalDeclinePO }}</h3>
          </template>

          <template slot="footer">
            <div class="stats">
              <md-icon>date_range</md-icon>
              {{ new Date().getFullYear() }}
            </div>
          </template>
        </stats-card>
      </div>
      <div
        class="md-layout-item md-medium-size-100 md-xsmall-size-100 md-size-50"
      >
        <chart-card
          :chart-data="totalPOChart.data"
          :chart-options="totalPOChart.options"
          :chart-type="'Line'"
          :key="componentKey"
          data-background-color="blue"
        >
          <template slot="content">
            <h4 class="title">Total PO</h4>
          </template>

          <template slot="footer">
            <div class="stats">
              <md-icon>access_time</md-icon>
              {{ new Date().toLocaleString() }}
            </div>
          </template>
        </chart-card>
      </div>
      <div
        class="md-layout-item md-medium-size-100 md-xsmall-size-100 md-size-50"
      >
        <chart-card
          :chart-data="totalPODeclineChart.data"
          :chart-options="totalPODeclineChart.options"
          :chart-responsive-options="totalPODeclineChart.responsiveOptions"
          :chart-type="'Bar'"
          :key="componentKey"
          data-background-color="red"
        >
          <template slot="content">
            <h4 class="title">Total Declined PO</h4>
          </template>

          <template slot="footer">
            <div class="stats">
              <md-icon>access_time</md-icon>
              {{ new Date().toLocaleString() }}
            </div>
          </template>
        </chart-card>
      </div>
      <div
        class="md-layout-item md-medium-size-100 md-xsmall-size-100 md-size-50"
      >
        <chart-card
          :chart-data="pendingOneChart.data"
          :chart-options="pendingOneChart.options"
          :chart-type="'Line'"
          :key="componentKey"
          data-background-color="green"
        >
          <template slot="content">
            <h4 class="title">Pending 1</h4>
            <p class="category">Time taken for First Approval</p>
          </template>

          <template slot="footer">
            <div class="stats">
              <md-icon>access_time</md-icon>
              {{ new Date().toLocaleString() }}
            </div>
          </template>
        </chart-card>
      </div>
      <div
        class="md-layout-item md-medium-size-100 md-xsmall-size-100 md-size-50"
      >
        <chart-card
          :chart-data="pendingTwoChart.data"
          :chart-options="pendingTwoChart.options"
          :chart-type="'Line'"
          :key="componentKey"
          data-background-color="blue"
        >
          <template slot="content">
            <h4 class="title">Pending 2</h4>
            <p class="category">Time taken for Second Approval</p>
          </template>

          <template slot="footer">
            <div class="stats">
              <md-icon>access_time</md-icon>
              {{ new Date().toLocaleString() }}
            </div>
          </template>
        </chart-card>
      </div>
      <div
        class="md-layout-item md-medium-size-100 md-xsmall-size-100 md-size-50"
      >
        <chart-card
          :chart-data="approvalChart.data"
          :chart-options="approvalChart.options"
          :chart-responsive-options="approvalChart.responsiveOptions"
          :chart-type="'Bar'"
          :key="componentKey"
          data-background-color="red"
        >
          <template slot="content">
            <h4 class="title">Approval</h4>
            <p class="category">Time Taken for Final Approval</p>
          </template>

          <template slot="footer">
            <div class="stats">
              <md-icon>access_time</md-icon>
              {{ new Date().toLocaleString() }}
            </div>
          </template>
        </chart-card>
      </div>
      <div
        class="md-layout-item md-medium-size-100 md-xsmall-size-100 md-size-50"
      >
        <chart-card
          :chart-data="dataDeclineChart.data"
          :chart-options="dataDeclineChart.options"
          :chart-type="'Line'"
          :key="componentKey"
          data-background-color="green"
        >
          <template slot="content">
            <h4 class="title">Decline</h4>
            <p class="category">Time taken for Decline</p>
          </template>

          <template slot="footer">
            <div class="stats">
              <md-icon>access_time</md-icon>
              {{ new Date().toLocaleString() }}
            </div>
          </template>
        </chart-card>
      </div>
    </div>
  </div>
</template>

<script>
import performance from "@/js/performance.js";
import { required } from "vuelidate/lib/validators";
import { StatsCard, ChartCard } from "@/components";

export default {
  components: {
    StatsCard,
    ChartCard,
  },
  data() {
    return {
      isEmpty: false,
      year: 2021,
      performanceData: [],
      totalPO: 0,
      efficiency: 0,
      totalDeclinePO: 0,
      componentKey: 0,
      isPosted: false,
      totalPOChart: {
        data: {
          labels: [
            "Jan",
            "Feb",
            "Mar",
            "Apr",
            "May",
            "Jun",
            "Jul",
            "Aug",
            "Sep",
            "Oct",
            "Nov",
            "Dec",
          ],
          series: [],
        },
        options: {
          lineSmooth: this.$Chartist.Interpolation.cardinal({
            tension: 0,
          }),
          low: 0,
          high: 100,
          chartPadding: {
            top: 0,
            right: 0,
            bottom: 0,
            left: 0,
          },
          tooltips: {
            enabled: true,
            display: true,
          },
        },
      },
      totalPODeclineChart: {
        data: {
          labels: [
            "Jan",
            "Feb",
            "Mar",
            "Apr",
            "May",
            "Jun",
            "Jul",
            "Aug",
            "Sep",
            "Oct",
            "Nov",
            "Dec",
          ],
          series: [],
        },
        options: {
          axisX: {
            showGrid: false,
          },
          low: 0,
          high: 100,
          chartPadding: {
            top: 0,
            right: 5,
            bottom: 0,
            left: 0,
          },
        },
        responsiveOptions: [
          [
            "screen and (max-width: 640px)",
            {
              seriesBarDistance: 5,
              axisX: {
                labelInterpolationFnc: function (value) {
                  return value[0];
                },
              },
            },
          ],
        ],
      },
      pendingOneChart: {
        data: {
          labels: [
            "Jan",
            "Feb",
            "Mar",
            "Apr",
            "May",
            "Jun",
            "Jul",
            "Aug",
            "Sep",
            "Oct",
            "Nov",
            "Dec",
          ],
          series: [],
        },
        options: {
          lineSmooth: this.$Chartist.Interpolation.cardinal({
            tension: 0,
          }),
          low: 0,
          high: 100, // creative tim: we recommend you to set the high sa the biggest value + something for a better look
          chartPadding: {
            top: 0,
            right: 0,
            bottom: 0,
            left: 0,
          },
        },
      },
      pendingTwoChart: {
        data: {
          labels: [
            "Jan",
            "Feb",
            "Mar",
            "Apr",
            "May",
            "Jun",
            "Jul",
            "Aug",
            "Sep",
            "Oct",
            "Nov",
            "Dec",
          ],
          series: [],
        },
        options: {
          lineSmooth: this.$Chartist.Interpolation.cardinal({
            tension: 0,
          }),
          low: 0,
          high: 100, // creative tim: we recommend you to set the high sa the biggest value + something for a better look
          chartPadding: {
            top: 0,
            right: 0,
            bottom: 0,
            left: 0,
          },
        },
      },
      approvalChart: {
        data: {
          labels: [
            "Jan",
            "Feb",
            "Mar",
            "Apr",
            "May",
            "Jun",
            "Jul",
            "Aug",
            "Sep",
            "Oct",
            "Nov",
            "Dec",
          ],
          series: [],
        },
        options: {
          axisX: {
            showGrid: false,
          },
          low: 0,
          high: 150,
          chartPadding: {
            top: 0,
            right: 5,
            bottom: 0,
            left: 0,
          },
        },
        responsiveOptions: [
          [
            "screen and (max-width: 640px)",
            {
              seriesBarDistance: 5,
              axisX: {
                labelInterpolationFnc: function (value) {
                  return value[0];
                },
              },
            },
          ],
        ],
      },
      dataDeclineChart: {
        data: {
          labels: [
            "Jan",
            "Feb",
            "Mar",
            "Apr",
            "May",
            "Jun",
            "Jul",
            "Aug",
            "Sep",
            "Oct",
            "Nov",
            "Dec",
          ],
          series: [],
        },

        options: {
          lineSmooth: this.$Chartist.Interpolation.cardinal({
            tension: 0,
          }),
          low: 0,
          high: 150, // creative tim: we recommend you to set the high sa the biggest value + something for a better look
          chartPadding: {
            top: 0,
            right: 0,
            bottom: 0,
            left: 0,
          },
        },
      },
    };
  },
  async created() {
    try {
      this.isLoading = true;
      const data = await performance.get_performance(this.year);
      this.performanceData = data;
      this.getAllData(this.performanceData);
      this.isLoading = false;
      this.forceRender();
    } catch (err) {
      this.isLoading = false;
      this.error = err.message;
    }
  },
  validations: {
    year: {
      required,
    },
  },
  methods: {
    async filter_year() {
      this.isPosted = true;
      if (!this.$v.$invalid) {
        try {
          this.isLoading = true;
          this.performanceData = await performance.get_performance(this.year);
          console.log(this.year);
          console.log(this.performanceData);
          // this.getAllData(newData);
          this.isLoading = false;
          this.forceRender();
        } catch (err) {
          this.isLoading = false;
          alert(err);
          this.error = err.message;
        }
      } else alert("Fill the required fields");
    },
    async getTotalPO(data) {
      for (let dataMonth in data.overall) {
        this.totalPO +=
          data.overall[dataMonth].total_po == null
            ? 0
            : parseInt(data.overall[dataMonth].total_po);
      }
    },

    async getEfficiency(data) {
      let totalEfficiency = 0;
      for (let dataMonth in data.overall) {
        totalEfficiency +=
          data.overall[dataMonth].po_efficiency == null
            ? 0
            : parseInt(data.overall[dataMonth].po_efficiency);
      }
      this.efficiency = (totalEfficiency / 12).toFixed(2);
    },

    async getTotalDeclinePO(data) {
      for (let dataMonth in data.overall) {
        this.totalDeclinePO +=
          data.overall[dataMonth].total_po_decline == null
            ? 0
            : parseInt(data.overall[dataMonth].total_po_decline);
      }
    },

    async getTotalPOseries(data) {
      let POseries = Array();
      for (let dataMonth in data.overall) {
        POseries.push(
          data.overall[dataMonth].total_po == null
            ? 0
            : parseInt(data.overall[dataMonth].total_po)
        );
      }
      this.totalPOChart.data.series.push(POseries);
    },

    async getTotalPODeclineSeries(data) {
      let PODeclineSeries = Array();
      for (let dataMonth in data.overall) {
        PODeclineSeries.push(
          data.overall[dataMonth].total_po_decline == null
            ? 0
            : parseInt(data.overall[dataMonth].total_po_decline)
        );
      }
      this.totalPODeclineChart.data.series.push(PODeclineSeries);
    },
    async getPendingOneseries(data) {
      let series = Array();
      for (let dataMonth in data.overall) {
        series.push(
          data.overall[dataMonth].tmp_average_po.pending_1.minutes == null
            ? 0
            : parseInt(data.overall[dataMonth].tmp_average_po.pending_1.minutes)
        );
      }
      this.pendingOneChart.data.series.push(series);
    },
    async getPendingTwoseries(data) {
      let series = Array();
      for (let dataMonth in data.overall) {
        series.push(
          data.overall[dataMonth].tmp_average_po.pending_2.minutes == null
            ? 0
            : parseInt(data.overall[dataMonth].tmp_average_po.pending_2.minutes)
        );
      }
      this.pendingTwoChart.data.series.push(series);
    },
    async getApprovalseries(data) {
      let series = Array();
      for (let dataMonth in data.overall) {
        series.push(
          data.overall[dataMonth].tmp_average_po.approve.minutes == null
            ? 0
            : parseInt(data.overall[dataMonth].tmp_average_po.approve.minutes)
        );
      }
      this.approvalChart.data.series.push(series);
    },
    async getDeclineseries(data) {
      let series = Array();
      for (let dataMonth in data.overall) {
        series.push(
          data.overall[dataMonth].tmp_average_po.decline.minutes == null
            ? 0
            : parseInt(data.overall[dataMonth].tmp_average_po.decline.minutes)
        );
      }
      this.dataDeclineChart.data.series.push(series);
    },
    forceRender() {
      this.componentKey += 1;
    },
    async getAllData(data) {
      await this.getTotalPO(data);
      await this.getEfficiency(data);
      await this.getTotalDeclinePO(data);
      await this.getTotalPOseries(data);
      await this.getTotalPODeclineSeries(data);
      await this.getPendingOneseries(data);
      await this.getPendingTwoseries(data);
      await this.getApprovalseries(data);
      await this.getDeclineseries(data);
    }
  },
};
</script>
