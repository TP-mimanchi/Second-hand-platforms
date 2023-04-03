
<template>
  <div class="dashboard-editor-container">
    <panel-group />
    <el-row :gutter="32">
      <el-col :xs="24" :sm="24" :lg="8">
        <div class="chart-wrapper">
          <h4 align="center">帖子分类统计</h4>
          <pie-chart />
        </div>
      </el-col>
      <el-col :xs="24" :sm="24" :lg="7">
        <div class="chart-wrapper">
          <h4 align="center">表白墙分类统计</h4>
          <wall-bar-chart :x-axis-data="wallXAxisData" :series-data="wallSeriesData" />
        </div>
      </el-col>
      <el-col :xs="24" :sm="24" :lg="9">
        <div class="chart-wrapper">
          <h4 align="center">二手上架分类统计</h4>
          <goods-bar-chart :x-axis-data="goodsXAxisData" :series-data="goodsSeriesData" />
        </div>
      </el-col>
    </el-row>
  </div>
</template>

<script>
import PanelGroup from './components/PanelGroup'
import PieChart from './components/PieChart'
import WallBarChart from './components/BarChart'
import GoodsBarChart from './components/BarChart'
import { fetchWallCountByState } from '@/api/wall'
import { fetchGoodsCountByCategory } from '@/api/market'

export default {
  name: 'DashboardAdmin',
  components: {
    PanelGroup,
    PieChart,
    WallBarChart,
    GoodsBarChart
  },
  data() {
    return {
      wallXAxisData: [],
      wallSeriesData: [],
      goodsXAxisData: [],
      goodsSeriesData: []
    }
  },
  async  mounted() {
    await this.getWallCountGroupByState()
    await this.getGoodsCountByCategory()
  },
  methods: {
    async getWallCountGroupByState() {
      const _this = this
      await fetchWallCountByState().then(res => {
        if (res.data.length > 0) {
          res.data.forEach(function(item) {
            _this.wallXAxisData.push(item.stateName)
            _this.wallSeriesData.push(item.auditStateCount)
          })
        }
      })
    },
    async getGoodsCountByCategory() {
      const _this = this
      await fetchGoodsCountByCategory().then(res => {
        if (res.data.length > 0) {
          res.data.forEach(function(item) {
            _this.goodsXAxisData.push(item.categoryName)
            _this.goodsSeriesData.push(item.goodsCategoryIdCount)
          })
        }
      })
    }

  }
}
</script>

<style lang="scss" scoped>
.dashboard-editor-container {
  padding: 32px;
  background-color: rgb(240, 242, 245);
  position: relative;

  .github-corner {
    position: absolute;
    top: 0px;
    border: 0;
    right: 0;
  }

  .chart-wrapper {
    background: #fff;
    padding: 16px 16px 0;
    margin-bottom: 32px;
  }
}

@media (max-width:1024px) {
  .chart-wrapper {
    padding: 8px;
  }
}
</style>
