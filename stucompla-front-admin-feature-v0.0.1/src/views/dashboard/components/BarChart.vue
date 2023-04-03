<template>
  <div :class="className" :style="{height:height,width:width}" />
</template>

<script>
import echarts from 'echarts'
require('echarts/theme/macarons') // echarts theme
import resize from './mixins/resize'

const animationDuration = 3000

export default {
  mixins: [resize],
  props: {
    className: {
      type: String,
      default: 'chart'
    },
    width: {
      type: String,
      default: '100%'
    },
    height: {
      type: String,
      default: '350px'
    },
    xAxisData: {
      type: Array
    },
    seriesData: {
      type: Array

    }
  },
  data() {
    return {
      chart: null
    }
  },
  watch: {
    xAxisData: {
      handler(newVal, oldVal) {
        console.log(newVal)
        this.initChart()
      }
    }
  },
  mounted() {
    this.$nextTick(() => {
      this.initChart()
    })
  },
  created() {

  },
  beforeDestroy() {
    if (!this.chart) {
      return
    }
    this.chart.dispose()
    this.chart = null
  },
  methods: {
    initChart() {
      this.chart = echarts.init(this.$el, 'macarons')
      this.chart.setOption({
        tooltip: {
          trigger: 'axis',
          axisPointer: { // 坐标轴指示器，坐标轴触发有效
            type: 'shadow' // 默认为直线，可选为：'line' | 'shadow'
          }
        },
        grid: {
          top: 10,
          left: '2%',
          right: '2%',
          bottom: '3%',
          containLabel: true
        },
        xAxis: [{
          type: 'category',
          data: this.xAxisData,
          triggerEvent: true, // 开启坐标轴的标签响应和触发鼠标事件
          axisTick: {
            alignWithLabel: true
          },
          axisLabel: {
            // 加入这段代码隐藏过长的文字,长度可以自己定义
            formatter: function(value) {
              var res = value
              if (res.length > 4) {
                res = res.substring(0, 4) + '..'
              }
              return res
            }
          }

        }],
        yAxis: [{
          type: 'value',
          axisTick: {
            show: false
          }
        }],
        series: [{
          name: 'count',
          type: 'bar',
          stack: 'vistors',
          barWidth: '60%',
          data: this.seriesData,
          animationDuration
        }]
      })
    }
  }
}
</script>
