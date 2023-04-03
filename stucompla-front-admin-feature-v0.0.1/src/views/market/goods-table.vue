<template>
  <div class="app-container">
    <div class="filter-container">
      <el-input v-model="listQuery.goodsId" placeholder="商品ID" style="width: 150px;" class="filter-item" @keyup.enter.native="handleFilter" />
      <el-input v-model="listQuery.userId" placeholder="卖家ID" style="width: 150px;" class="filter-item" @keyup.enter.native="handleFilter" />
      <el-input v-model="listQuery.keyName" placeholder="关键词" style="width: 150px;" class="filter-item" @keyup.enter.native="handleFilter" />
      <el-select v-model="listQuery.goodsStatus" placeholder="商品状态" clearable style="width: 150px" class="filter-item" @change="handleFilter">
        <el-option v-for="item in statusOptions" :key="item.key" :label="item.label" :value="item.key" />
      </el-select>
      <el-select v-model="listQuery.sort" style="width: 140px" class="filter-item" @change="handleFilter">
        <el-option v-for="item in sortOptions" :key="item.key" :label="item.label" :value="item.key" />
      </el-select>

      <el-button v-waves class="filter-item" type="primary" icon="el-icon-search" @click="handleFilter">
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
      <el-table-column label="商品ID" prop="goodsId" sortable="custom" align="center" width="80" :class-name="getSortClass('goods_id')">
        <template slot-scope="{row}">
          <span>{{ row.goodsId }}</span>
        </template>
      </el-table-column>
      <el-table-column label="卖家" align="center">
        <template slot-scope="{row}">
          <span>{{ row.user.username }}</span>
        </template>
      </el-table-column>
      <el-table-column label="商品名" align="left">
        <template slot-scope="{row}">
          <el-tooltip class="item" :content="row.goodsName" placement="bottom" effect="light">
            <span class="span-single-show">{{ row.goodsName }}</span>
          </el-tooltip>
        </template>
      </el-table-column>
      <el-table-column label="商品详情" align="left" width="200px">
        <template slot-scope="{row}">
          <el-tooltip class="item" :content="row.goodsDetail" placement="bottom" effect="light">
            <span class="span-single-show">{{ row.goodsDetail }}</span>
          </el-tooltip>
        </template>
      </el-table-column>
      <el-table-column label="图片" width="90px" align="center">
        <template slot-scope="{row}">
          <el-image
            v-if="row.goodsImages!==null"
            style="width: 60px; height: 60px"
            :src="row.goodsImages[0]"
            :preview-src-list="row.goodsImages"
          />
        </template>
      </el-table-column>
      <el-table-column label="分类" width="90px" align="center">
        <template slot-scope="{row}">
          <span>{{ row.goodsCategory.categoryName }}</span>
        </template>
      </el-table-column>
      <el-table-column label="价格" width="155px" align="center">
        <template slot-scope="{row}">
          <span>{{ row.goodsPrice }}</span>
        </template>
      </el-table-column>
      <el-table-column label="库存" width="155px" align="center">
        <template slot-scope="{row}">
          <span>{{ row.goodsCount }}</span>
        </template>
      </el-table-column>
      <el-table-column label="商品状态" class-name="status-col" width="80px" align="center">
        <template slot-scope="{row}">
          <!-- 可以写一个下架时，鼠标放到上面就会显示下架的原因-->
          <el-tag :type="row.goodsStatus | statusFilter">
            {{ row.goodsStatus==0?'已下架':'上架中' }}
          </el-tag>
        </template>
      </el-table-column>
      <el-table-column label="浏览数" width="70px" align="center">
        <template slot-scope="{row}">
          <span>{{ row.viewNum }}</span>
        </template>
      </el-table-column>
      <!--操作-->
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template slot-scope="{row}">
          <el-popover
            v-if="row.goodsStatus==1"
            placement="left"
            title="下架"
            width="240"
            trigger="click"
          >
            <div style="text-align: center">
              <el-input v-model="unShelveCause" type="textarea" :maxlength="30" placeholder="请填写下架原因（必填）" />
              <p style="">
                <el-button size="mini" type="primary" @click="handleUnShelve(row.goodsId)">
                  确定
                </el-button>
              </p>
            </div>
            <el-button slot="reference" size="mini" type="primary">
              下架
            </el-button>
          </el-popover>
          <el-popconfirm
            confirm-button-text="确定"
            cancel-button-text="取消"
            icon="el-icon-info"
            icon-color="red"
            title="确定删除该商品吗？此操作不可恢复！"
            @confirm="deleteGoods(row.goodsId,$index)"
          >
            <el-button slot="reference" size="mini" type="danger">
              删除
            </el-button>
          </el-popconfirm>

        </template>
      </el-table-column>
    </el-table>

    <pagination v-show="total>0" :total="total" :page.sync="listQuery.pageNum" :limit.sync="listQuery.pageSize" @pagination="getList" />

  </div>
</template>

<script>
import { fetchGoodsList, unShelve, deleteGoods } from '@/api/market'
import waves from '@/directive/waves' // waves directive
import Pagination from '@/components/Pagination' // secondary package based on el-pagination

export default {
  name: 'ComplexTable',
  components: { Pagination },
  directives: { waves },
  filters: {
    statusFilter(status) {
      const statusMap = {
        false: 'danger',
        true: 'success'
      }
      return statusMap[status]
    }
  },
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
        pageSize: 20,
        goodsId: undefined,
        userId: undefined,
        keyName: undefined, // 商品名和详情中模糊搜索
        sort: '-goods_id', // 设定默认goods_id降序排序
        goodsStatus: undefined,
        goodsCategoryId: undefined
      },
      statusOptions: [{ label: '上架中', key: true }, { label: '已下架', key: false }],
      unShelveCause: undefined,
      sortOptions: [
        { label: 'ID降序', key: '-goods_id' },
        { label: 'ID升序', key: '+goods_id' },
        { label: '价格升序', key: '+goods_price' },
        { label: '价格降序', key: '-goods_price' }
      ]

    }
  },
  async created() {
    await this.getList()
  },
  methods: {
    async getList() {
      await fetchGoodsList(this.listQuery).then(response => {
        this.list = response.data.goodsList
        this.list.forEach(function(item) {
          if (item.goodsImages !== null) {
            const srcArr = item.goodsImages.split(',')
            const srcList = []
            srcArr.forEach(function(item1) {
              srcList.push('http://localhost:8086/image/' + item1)
            })
            item.goodsImages = srcList
          }
        })
        this.total = response.data.total
        this.listLoading = false
      })
    },
    handleFilter() {
      this.listQuery.pageNum = 1
      this.getList()
    },

    sortChange(data) {
      const { prop, order } = data
      if (prop === 'goodsId') {
        this.sortByID(order)
      }
    },
    sortByID(order) {
      if (order === 'ascending') {
        this.listQuery.sort = '+goods_id'
      } else {
        this.listQuery.sort = '-goods_id'
      }
      this.handleFilter()
    },
    handleUnShelve(goodsId) {
      unShelve(goodsId).then(res => {
        console.log(res)
        this.$message.success(res.msg)
        this.$router.go(0)
      })
    },

    deleteGoods(goodsId, index) {
      deleteGoods(goodsId).then(res => {
        console.log(res)
        this.$message.success(res.msg)
        this.list.splice(index, 1)
      })
    },

    getSortClass: function(key) {
      const sort = this.listQuery.sort
      return sort === `+${key}` ? 'ascending' : 'descending'
    }
  }
}
</script>
<style>
.span-single-show{
  font-size: 12px;
  white-space:nowrap;/*强制单行显示*/
  text-overflow:ellipsis;/*超出部分省略号表示*/
  overflow:hidden;/*超出部分隐藏*/
  width: 100%;/*设置显示的最大宽度*/
  display:inline-block;
}
</style>
