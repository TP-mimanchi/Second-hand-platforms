<template>
  <div class="app-container">
    <div class="filter-container">
      <el-input v-model="listQuery.orderId" placeholder="订单ID" style="width: 150px;" class="filter-item" @keyup.enter.native="handleFilter" />
      <el-input v-model="listQuery.buyerId" placeholder="买家ID" style="width: 150px;" class="filter-item" @keyup.enter.native="handleFilter" />
      <el-input v-model="listQuery.sellerId" placeholder="卖家ID" style="width: 150px;" class="filter-item" @keyup.enter.native="handleFilter" />
      <el-input v-model="listQuery.goodsId" placeholder="商品ID" style="width: 150px;" class="filter-item" @keyup.enter.native="handleFilter" />
      <el-select v-model="listQuery.orderStatus" placeholder="订单状态" clearable style="width: 150px" class="filter-item" @change="handleFilter">
        <el-option v-for="item in statusOptions" :key="item.key" :label="item.label" :value="item.key" />
      </el-select>
      <el-select v-model="listQuery.sort" style="width: 140px" class="filter-item" @change="handleFilter">
        <el-option v-for="item in sortOptions" :key="item.key" :label="item.label" :value="item.key" />
      </el-select>

      <el-button class="filter-item" type="primary" icon="el-icon-search" @click="handleFilter">
        搜索
      </el-button>

    </div>

    <el-table
      :key="tableKey"
      v-loading="listLoading"
      :data="list"
      border
      fit
      highlight-current-row
      style="width: 100%;"
      @sort-change="sortChange"
    >
      <el-table-column label="订单ID" prop="orderId" sortable="custom" align="center" width="90" :class-name="getSortClass('order_id')">
        <template slot-scope="{row}">
          <span>{{ row.orderId }}</span>
        </template>
      </el-table-column>
      <el-table-column label="买家ID" align="left" width="70">
        <template slot-scope="{row}">
          <span>{{ row.buyer.userId }}</span>
        </template>
      </el-table-column>
      <el-table-column label="卖家ID" align="left" width="70">
        <template slot-scope="{row}">
          <span>{{ row.seller.userId }}</span>
        </template>
      </el-table-column>
      <el-table-column label="商品ID" align="left" width="70">
        <template slot-scope="{row}">
          <span>{{ row.goodsId }}</span>
        </template>
      </el-table-column>
      <el-table-column label="商品名" align="left">
        <template slot-scope="{row}">
          <span>{{ row.goodsName }}</span>
        </template>
      </el-table-column>
      <el-table-column label="单价" align="left" width="60">
        <template slot-scope="{row}">
          <span>{{ row.goodsPrice }}</span>
        </template>
      </el-table-column>
      <el-table-column label="购买数量" align="left">
        <template slot-scope="{row}">
          <span>{{ row.buyCount }}</span>
        </template>
      </el-table-column>
      <el-table-column label="订单总价" prop="totalPrice" sortable="custom" align="left" :class-name="getSortClass('total_price')">
        <template slot-scope="{row}">
          <span>{{ row.totalPrice }}</span>
        </template>
      </el-table-column>
      <el-table-column label="创建时间" width="160px" align="center">
        <template slot-scope="{row}">
          <span>{{ row.createTime }}</span>
        </template>
      </el-table-column>
      <el-table-column label="订单状态" class-name="status-col" width="80px" align="center">
        <template slot-scope="{row}">
          <span>{{ getOrderStatus(row.orderStatus) }}</span>
        </template>
      </el-table-column>
      <el-table-column label="更新时间" prop="updateTime" sortable="custom" width="160px" align="center" :class-name="getSortClass('update_time')">
        <template slot-scope="{row}">
          <span>{{ row.updateTime }}</span>
        </template>
      </el-table-column>
    </el-table>

    <pagination v-show="total>0" :total="total" :page.sync="listQuery.pageNum" :limit.sync="listQuery.pageSize" @pagination="getList" />

  </div>
</template>

<script>
import waves from '@/directive/waves' // waves directive
import Pagination from '@/components/Pagination'
import { fetchOrderList } from '@/api/market' // secondary package based on el-pagination

export default {
  name: 'ComplexTable',
  components: { Pagination },
  directives: { waves },

  data() {
    return {
      auditRadio: '1',
      auditCause: undefined,
      tableKey: 0,
      list: null,
      total: 0,
      listLoading: true,
      listQuery: {
        pageNum: 1,
        pageSize: 8,
        orderId: undefined,
        buyerId: undefined,
        sellerId: undefined,
        goodsId: undefined,
        sort: '+order_id',
        orderStatus: undefined
      },
      // 0-未付 1-已付 2-已发货 3-已签收 4-退货中 5-已退货
      statusOptions: [
        { label: '待支付', key: '0' }, { label: '待发货', key: '1' },
        { label: '待签收', key: '2' }, { label: '已签收', key: '3' },
        { label: '退货中', key: '4' }, { label: '已退货', key: '5' }],
      sortOptions: [
        { label: 'ID升序', key: '+order_id' },
        { label: 'ID降序', key: '-order_id' },
        { label: '更新时间升序', key: '+update_time' },
        { label: '更新时间降序', key: '-update_time' },
        { label: '总价升序', key: '+total_price' },
        { label: '总价降序', key: '-total_price' }
      ],

      // 数据校验
      rules: {
        type: [{ required: true, message: 'type is required', trigger: 'change' }],
        timestamp: [{ type: 'date', required: true, message: 'timestamp is required', trigger: 'change' }],
        title: [{ required: true, message: 'title is required', trigger: 'blur' }]
      }
    }
  },
  async created() {
    await this.getList()
  },
  methods: {
    async getList() {
      await fetchOrderList(this.listQuery).then(res => {
        this.list = res.data.orderList
        this.total = res.data.total
        console.log(this.list)
        this.listLoading = false
      })
    },
    handleFilter() {
      this.listQuery.pageNum = 1
      this.getList()
    },

    sortChange(data) {
      const { prop, order } = data
      if (prop === 'orderId') {
        this.sortByID(order)
      }
      if (prop === 'totalPrice') {
        this.sortByTotalPrice(order)
      }
      if (prop === 'updateTime') {
        this.sortByUpdateTime(order)
      }
    },
    sortByID(order) {
      if (order === 'ascending') {
        this.listQuery.sort = '+order_id'
      } else {
        this.listQuery.sort = '-order_id'
      }
      this.handleFilter()
    },
    sortByTotalPrice(order) {
      if (order === 'ascending') {
        this.listQuery.sort = '+total_price'
      } else {
        this.listQuery.sort = '-total_price'
      }
      this.handleFilter()
    },
    sortByUpdateTime(order) {
      if (order === 'ascending') {
        this.listQuery.sort = '+update_time'
      } else {
        this.listQuery.sort = '-update_time'
      }
      this.handleFilter()
    },
    getOrderStatus(status) {
      console.log(status)
      if (status === 0) {
        return '待支付'
      } else if (status === 1) {
        return '待发货'
      } else if (status === 2) {
        return '待签收'
      } else if (status === 3) {
        return '已签收'
      } else if (status === 4) {
        return '退货中'
      } else if (status === 5) {
        return '已退货'
      }
    },
    getSortClass: function(key) {
      const sort = this.listQuery.sort
      return sort === `+${key}` ? 'ascending' : 'descending'
    }
  }
}
</script>
<style>
.span-wallContent{
  font-size: 12px;
  white-space:nowrap;/*强制单行显示*/
  text-overflow:ellipsis;/*超出部分省略号表示*/
  overflow:hidden;/*超出部分隐藏*/
  width: 100%;/*设置显示的最大宽度*/
  display:inline-block;
}
</style>
