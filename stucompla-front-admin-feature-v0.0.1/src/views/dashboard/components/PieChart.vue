<template>
  <div :class="className" :style="{height:height,width:width}" />
</template>

<script>
import echarts from 'echarts'
require('echarts/theme/macarons') // echarts theme
import resize from './mixins/resize'
import { fetchPostCountByCategory } from '@/api/post'

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
    }
  },
  data() {
    return {
      chart: null,
      legendData: [],
      seriesData: []
    }
  },
  async mounted() {
    await this.getPostCountGroupByCategory()
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
    async getPostCountGroupByCategory() {
      const _this = this
      await fetchPostCountByCategory().then(res => {
        if (res.data.length > 0) {
          res.data.forEach(function(item) {
            _this.legendData.push(item.categoryName)
            _this.seriesData.push({ value: item.categoryIdCount, name: item.categoryName })
          })
        }
        console.log(_this.legendData)
        console.log(_this.seriesData)
        console.log(res.data)
      })
    },
    initChart() {
      this.chart = echarts.init(this.$el, 'macarons')
      this.chart.setOption({
        tooltip: {
          trigger: 'item',
          formatter: '{a} <br/>{b} : {c} ({d}%)'
        },
        legend: {
          left: 'center',
          bottom: '10',
          data: this.legendData
        },
        series: [
          {
            name: '帖子分类统计',
            type: 'pie',
            roseType: 'radius',
            radius: [15, 95],
            center: ['50%', '38%'],
            data: this.seriesData,
            animationEasing: 'cubicInOut',
            animationDuration: 2600
          }
        ]
      })
    }
  }
}
</script>
