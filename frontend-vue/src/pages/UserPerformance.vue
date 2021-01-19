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
            <td class="clsLabel">Year:</td>
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
            <md-icon>article</md-icon>
          </template>

          <template slot="content">
            <p class="category">Total Approve PO/Total PO</p>
            <h3 class="title">{{ totalPO - totalDeclinePO }}/{{ totalPO }}</h3>
          </template>

          <template slot="footer">
            <div class="stats">
              <md-icon>date_range</md-icon>
              {{ new Date().toLocaleString() }}
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
            <h3 class="title">{{ POefficiency }}%</h3>
          </template>

          <template slot="footer">
            <div class="stats">
              <md-icon>date_range</md-icon>
              {{ new Date().toLocaleString() }}
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
            <p class="category">Total Approve PSR/Total PSR</p>
            <h3 class="title">
              {{ totalPSR - totalDeclinePSR }}/{{ totalPSR }}
            </h3>
          </template>

          <template slot="footer">
            <div class="stats">
              <md-icon>date_range</md-icon>
              {{ new Date().toLocaleString() }}
            </div>
          </template>
        </stats-card>
      </div>
      <div
        class="md-layout-item md-medium-size-50 md-xsmall-size-100 md-size-25"
      >
        <stats-card data-background-color="red">
          <template slot="header">
            <md-icon>content_copy</md-icon>
          </template>

          <template slot="content">
            <p class="category">Efficiency for PSR Approval</p>
            <h3 class="title">{{ PSRefficiency }}%</h3>
          </template>

          <template slot="footer">
            <div class="stats">
              <md-icon>date_range</md-icon>
              {{ new Date().toLocaleString() }}
            </div>
          </template>
        </stats-card>
      </div>
      <div
        class="md-layout-item md-medium-size-100 md-xsmall-size-100 md-size-50"
      >
        <chart-card
          :chart-data="POapprovalChart.data"
          :chart-options="POapprovalChart.options"
          :chart-responsive-options="POapprovalChart.responsiveOptions"
          :chart-type="'Bar'"
          :key="componentKey"
          data-background-color="red"
        >
          <template slot="content">
            <h4 class="title">PO Approval Per Month</h4>
            <p class="category">Time Taken for Final Approval (Min)</p>
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
          :chart-data="POdataDeclineChart.data"
          :chart-options="POdataDeclineChart.options"
          :chart-type="'Bar'"
          :key="componentKey"
          data-background-color="green"
        >
          <template slot="content">
            <h4 class="title">PO Decline Per Month</h4>
            <p class="category">Time taken for Decline (Min)</p>
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
          :chart-data="POpendingOneChart.data"
          :chart-options="POpendingOneChart.options"
          :chart-type="'Line'"
          :key="componentKey"
          data-background-color="green"
        >
          <template slot="content">
            <h4 class="title">PO Pending 1</h4>
            <p class="category">Time taken for First Approval (Min)</p>
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
          :chart-data="POpendingTwoChart.data"
          :chart-options="POpendingTwoChart.options"
          :chart-type="'Line'"
          :key="componentKey"
          data-background-color="blue"
        >
          <template slot="content">
            <h4 class="title">PO Pending 2</h4>
            <p class="category">Time taken for Second Approval (Min)</p>
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
          :chart-data="PSRapprovalChart.data"
          :chart-options="PSRapprovalChart.options"
          :chart-responsive-options="PSRapprovalChart.responsiveOptions"
          :chart-type="'Bar'"
          :key="componentKey"
          data-background-color="red"
        >
          <template slot="content">
            <h4 class="title">PSR Approval Per Month</h4>
            <p class="category">Time Taken for Final Approval (Min)</p>
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
          :chart-data="PSRdataDeclineChart.data"
          :chart-options="PSRdataDeclineChart.options"
          :chart-type="'Bar'"
          :key="componentKey"
          data-background-color="green"
        >
          <template slot="content">
            <h4 class="title">PSR Decline Per Month</h4>
            <p class="category">Time taken for Decline (Min)</p>
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
          :chart-data="PSRpendingOneChart.data"
          :chart-options="PSRpendingOneChart.options"
          :chart-type="'Line'"
          :key="componentKey"
          data-background-color="green"
        >
          <template slot="content">
            <h4 class="title">PSR Pending 1</h4>
            <p class="category">Time taken for First Approval (Min)</p>
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
          :chart-data="PSRpendingTwoChart.data"
          :chart-options="PSRpendingTwoChart.options"
          :chart-type="'Line'"
          :key="componentKey"
          data-background-color="blue"
        >
          <template slot="content">
            <h4 class="title">PSR Pending 2</h4>
            <p class="category">Time taken for Second Approval (Min)</p>
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
import {
  StatsCard,
  ChartCard
} from "@/components";

export default {
  components: {
    StatsCard,
    ChartCard
  },
  data() {
    return {
      isEmpty: false,
      isLoading: false,
      id: localStorage.id,
      year: 2021,
      performanceData: [],
      totalPO: 0,
      totalPSR: 0,
      POefficiency: 0,
      PSRefficiency: 0,
      totalDeclinePO: 0,
      totalDeclinePSR: 0,
      componentKey: 0,
      error: "",
      isPosted: false,

      POpendingOneChart: {
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
          high: 250,
          chartPadding: {
            top: 0,
            right: 0,
            bottom: 0,
            left: 0,
          },
        },
      },
      POpendingTwoChart: {
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
          high: 250, // creative tim: we recommend you to set the high sa the biggest value + something for a better look
          chartPadding: {
            top: 0,
            right: 0,
            bottom: 0,
            left: 0,
          },
        },
      },
      POapprovalChart: {
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
          high: 250,
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
      POdataDeclineChart: {
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
          high: 250, // creative tim: we recommend you to set the high sa the biggest value + something for a better look
          chartPadding: {
            top: 0,
            right: 0,
            bottom: 0,
            left: 0,
          },
        },
      },
      PSRpendingOneChart: {
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
          high: 250, // creative tim: we recommend you to set the high sa the biggest value + something for a better look
          chartPadding: {
            top: 0,
            right: 0,
            bottom: 0,
            left: 0,
          },
        },
      },
      PSRpendingTwoChart: {
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
          high: 250, // creative tim: we recommend you to set the high sa the biggest value + something for a better look
          chartPadding: {
            top: 0,
            right: 0,
            bottom: 0,
            left: 0,
          },
        },
      },
      PSRapprovalChart: {
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
          high: 250,
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
      PSRdataDeclineChart: {
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
          high: 250, // creative tim: we recommend you to set the high sa the biggest value + something for a better look
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
      const data = await performance.get_all_user_performance(this.year);
      this.performanceData = data;
      console.log(data);
      this.getAllData(this.performanceData);
      this.isLoading = false;
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
      detail(value) {
      console.log(value.id);
      this.$router.push({
        path: `/userPerformance/${this.id}`
      });
    },
    async filter_year() {
      this.isPosted = true;
      if (!this.$v.$invalid) {
        try {
          this.performanceData = [];
          this.isLoading = true;
          this.performanceData = await performance.get_all_user_performance(this.year);
          this.getAllData(this.performanceData);
          this.isLoading = false;
        } catch (err) {
          this.isLoading = false;
          alert(err);
          this.error = err.message;
        }
      } else alert("Fill the required fields");
    },
    async getTotalPO(data) {
      this.totalPO = 0;
      for (let dataMonth in data.user) {
        this.totalPO +=
          data.user[dataMonth].total_po == null
            ? 0
            : parseInt(data.user[dataMonth].total_po);
      }
    },

    async getPOEfficiency(data) {
      let totalEfficiency = 0;
      this.POefficiency = 0;
      let monthCount = 0;
      for (let dataMonth in data.user) {
        totalEfficiency +=
          data.user[dataMonth].po_efficiency == null
            ? 0
            : parseInt(data.user[dataMonth].po_efficiency);
        if (data.user[dataMonth].po_efficiency != null) {
          monthCount += 1;
        }
      }
      this.POefficiency = (totalEfficiency / monthCount).toFixed(2);
    },

    async getTotalDeclinePO(data) {
      this.totalDeclinePO = 0;
      for (let dataMonth in data.user) {
        this.totalDeclinePO +=
          data.user[dataMonth].total_po_decline == null
            ? 0
            : parseInt(data.user[dataMonth].total_po_decline);
      }
    },
    async getTotalPSR(data) {
      this.totalPSR = 0;
      for (let dataMonth in data.user) {
        this.totalPSR +=
          data.user[dataMonth].total_psr == null
            ? 0
            : parseInt(data.user[dataMonth].total_psr);
      }
    },

    async getPSREfficiency(data) {
      let totalEfficiency = 0;
      this.PSRefficiency = 0;
      let monthCount = 0;
      for (let dataMonth in data.user) {
        totalEfficiency +=
          data.user[dataMonth].psr_efficiency == null
            ? 0
            : parseInt(data.user[dataMonth].psr_efficiency);
        if (data.user[dataMonth].psr_efficiency != null) {
          monthCount += 1;
        }
      }
      this.PSRefficiency = (totalEfficiency / monthCount).toFixed(2);
    },

    async getTotalDeclinePSR(data) {
      this.totalDeclinePSR = 0;
      for (let dataMonth in data.user) {
        this.totalDeclinePSR +=
          data.user[dataMonth].total_psr_decline == null
            ? 0
            : parseInt(data.user[dataMonth].total_psr_decline);
      }
    },

    async getPOPendingOneseries(data) {
      this.POpendingOneChart.data.series.pop();
      let series = Array();
      for (let dataMonth in data.user) {
        series.push(
          data.user[dataMonth].tmp_average_po.pending_1.minutes == null
            ? 0
            : parseInt(data.user[dataMonth].tmp_average_po.pending_1.minutes)
        );
      }
      this.POpendingOneChart.options.high = Math.max.apply(Math, series) + 50;
      this.POpendingOneChart.data.series.push(series);
      this.forceRender();
    },
    async getPOPendingTwoseries(data) {
      this.POpendingTwoChart.data.series.pop();
      let series = Array();
      for (let dataMonth in data.user) {
        series.push(
          data.user[dataMonth].tmp_average_po.pending_2.minutes == null
            ? 0
            : parseInt(data.user[dataMonth].tmp_average_po.pending_2.minutes)
        );
      }
      this.POpendingTwoChart.data.series.push(series);
      this.POpendingTwoChart.options.high = Math.max.apply(Math, series) + 50;
      this.forceRender();
    },
    async getPOApprovalseries(data) {
      this.POapprovalChart.data.series.pop();
      let series = Array();
      for (let dataMonth in data.user) {
        series.push(
          data.user[dataMonth].tmp_average_po.approve.minutes == null
            ? 0
            : parseInt(data.user[dataMonth].tmp_average_po.approve.minutes)
        );
      }
      this.POapprovalChart.data.series.push(series);
      this.POapprovalChart.options.high = Math.max.apply(Math, series) + 50;
      this.forceRender();
    },
    async getPODeclineseries(data) {
      this.POdataDeclineChart.data.series.pop();
      let series = Array();
      for (let dataMonth in data.user) {
        series.push(
          data.user[dataMonth].tmp_average_po.decline.minutes == null
            ? 0
            : parseInt(data.user[dataMonth].tmp_average_po.decline.minutes)
        );
      }
      this.POdataDeclineChart.data.series.push(series);
      this.POdataDeclineChart.options.high = Math.max.apply(Math, series) + 50;
      this.forceRender();
    },
    async getPSRPendingOneseries(data) {
      this.PSRpendingOneChart.data.series.pop();
      let series = Array();
      for (let dataMonth in data.user) {
        series.push(
          data.user[dataMonth].tmp_average_psr.pending_1.minutes == null
            ? 0
            : parseInt(
                data.user[dataMonth].tmp_average_psr.pending_1.minutes
              )
        );
      }
      this.PSRpendingOneChart.data.series.push(series);
      this.PSRpendingOneChart.options.high = Math.max.apply(Math, series) + 50;
      this.forceRender();
    },
    async getPSRPendingTwoseries(data) {
      this.PSRpendingTwoChart.data.series.pop();
      let series = Array();
      for (let dataMonth in data.user) {
        series.push(
          data.user[dataMonth].tmp_average_psr.pending_2.minutes == null
            ? 0
            : parseInt(
                data.user[dataMonth].tmp_average_psr.pending_2.minutes
              )
        );
      }
      this.PSRpendingTwoChart.data.series.push(series);
      this.PSRpendingTwoChart.options.high = Math.max.apply(Math, series) + 50;
      this.forceRender();
    },
    async getPSRApprovalseries(data) {
      this.PSRapprovalChart.data.series.pop();
      let series = Array();
      for (let dataMonth in data.user) {
        series.push(
          data.user[dataMonth].tmp_average_psr.approve.minutes == null
            ? 0
            : parseInt(data.user[dataMonth].tmp_average_psr.approve.minutes)
        );
      }
      this.PSRapprovalChart.data.series.push(series);
      this.PSRapprovalChart.options.high = Math.max.apply(Math, series) + 50;
      this.forceRender();
    },
    async getPSRDeclineseries(data) {
      this.PSRdataDeclineChart.data.series.pop();
      let series = Array();
      for (let dataMonth in data.user) {
        series.push(
          data.user[dataMonth].tmp_average_psr.decline.minutes == null
            ? 0
            : parseInt(data.user[dataMonth].tmp_average_psr.decline.minutes)
        );
      }
      this.PSRdataDeclineChart.data.series.push(series);
      this.PSRdataDeclineChart.options.high = Math.max.apply(Math, series) + 50;
      this.forceRender();
    },
    forceRender() {
      this.componentKey += 1;
    },
    async getAllData(data) {
      await this.getTotalPO(data);
      await this.getPOEfficiency(data);
      await this.getTotalDeclinePO(data);
      await this.getTotalPSR(data);
      await this.getPSREfficiency(data);
      await this.getTotalDeclinePSR(data);

      await this.getPOApprovalseries(data);
      await this.getPODeclineseries(data);
      await this.getPOPendingOneseries(data);
      await this.getPOPendingTwoseries(data);

      await this.getPSRApprovalseries(data);
      await this.getPSRDeclineseries(data);
      await this.getPSRPendingOneseries(data);
      await this.getPSRPendingTwoseries(data);
    }
};
</script>
