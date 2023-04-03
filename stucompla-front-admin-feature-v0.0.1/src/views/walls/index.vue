<template>
  <div class="app-container">
    <div class="filter-container">
      <el-input v-model="listQuery.wallId" placeholder="墙ID" style="width: 150px;" class="filter-item" @keyup.enter.native="handleFilter" />
      <el-input v-model="listQuery.userId" placeholder="申请人ID" style="width: 150px;" class="filter-item" @keyup.enter.native="handleFilter" />
      <el-input v-model="listQuery.adminId" placeholder="审核人ID" style="width: 150px;" class="filter-item" @keyup.enter.native="handleFilter" />
      <el-select v-model="listQuery.auditState" placeholder="审核状态" clearable style="width: 150px" class="filter-item" @change="handleFilter">
        <el-option v-for="item in statusOptions" :key="item.key" :label="item.label" :value="item.key" />
      </el-select>
      <el-select v-model="listQuery.sort" style="width: 140px" class="filter-item" @change="handleFilter">
        <el-option v-for="item in sortOptions" :key="item.key" :label="item.label" :value="item.key" />
      </el-select>

      <el-button v-waves class="filter-item" type="primary" icon="el-icon-search" @click="handleFilter">
        搜索
      </el-button>

      <!--      导出功能未完善-->
      <el-button v-waves :loading="downloadLoading" class="filter-item" type="primary" icon="el-icon-download" @click="handleDownload">
        导出
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
      <el-table-column label="墙ID" prop="wallId" sortable="custom" align="center" width="80" :class-name="getSortClass('wall_id')">
        <template slot-scope="{row}">
          <span>{{ row.wallId }}</span>
        </template>
      </el-table-column>
      <el-table-column label="申请人ID" align="center">
        <template slot-scope="{row}">
          <span>{{ row.userId }}</span>
        </template>
      </el-table-column>
      <el-table-column label="内容" align="left" width="200px">
        <template slot-scope="{row}">
          <el-tooltip class="item" :content="row.wallContent" placement="bottom" effect="light">
            <span class="span-wallContent">{{ row.wallContent }}</span>
          </el-tooltip>
        </template>
      </el-table-column>
      <el-table-column label="图片" width="90px" align="center">
        <template slot-scope="{row}">
          <el-image
            v-if="row.wallImages!==null"
            style="width: 60px; height: 60px"
            :src="row.wallImages[0]"
            :preview-src-list="row.wallImages"
          />
        </template>
      </el-table-column>
      <el-table-column label="申请时间" width="155px" align="center">
        <template slot-scope="{row}">
          <span>{{ row.createtime }}</span>
        </template>
      </el-table-column>
      <el-table-column label="审核状态" class-name="status-col" width="80px" align="center">
        <template slot-scope="{row}">
          <!-- 审核不通过时，鼠标放到上面就会显示不通过的原因-->
          <el-tooltip class="item" :content="row.auditFailedCause" placement="bottom" effect="light" :disabled="row.auditState!=2">
            <el-tag :type="row.auditState | statusFilter">
              {{ row.auditState==0?'未审核':row.auditState==1?'通过':'不通过' }}
            </el-tag>
          </el-tooltip>
        </template>
      </el-table-column>
      <el-table-column label="审核人ID" align="center">
        <template slot-scope="{row}">
          <span>{{ row.adminId }}</span>
        </template>
      </el-table-column>
      <el-table-column label="审核时间" width="155px" align="center">
        <template slot-scope="{row}">
          <span>{{ row.auditTime }}</span>
        </template>
      </el-table-column>

      <!--      <el-table-column label="评论数" width="70px" align="center">-->
      <!--        <template slot-scope="{row}">-->
      <!--          <span>{{ row.commentNum }}</span>-->
      <!--        </template>-->
      <!--      </el-table-column>-->
      <!--      <el-table-column label="点赞数" width="70px" align="center">-->
      <!--        <template slot-scope="{row}">-->
      <!--          <span>{{ row.likeNum }}</span>-->
      <!--        </template>-->
      <!--      </el-table-column>-->
      <!--操作-->
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template slot-scope="{row}">
          <el-popover
            placement="left"
            title="审核"
            width="240"
            trigger="click"
          >
            <div style="text-align: center">
              <p>
                <el-radio v-model="auditRadio" label="1">审核通过</el-radio>
                <el-radio v-model="auditRadio" label="2">审核不通过</el-radio>
              </p>
              <p v-if="auditRadio==2">
                <el-input v-model="auditCause" type="textarea" :maxlength="30" placeholder="请填写不通过的原因（必填）" />
              </p>
              <p style="">
                <el-button size="mini" type="primary" @click="handleAudit(row)">
                  确定
                </el-button>
              </p>
            </div>
            <el-button slot="reference" size="mini" type="primary">
              审核
            </el-button>
          </el-popover>

        </template>
      </el-table-column>
    </el-table>

    <pagination v-show="total>0" :total="total" :page.sync="listQuery.pageNum" :limit.sync="listQuery.pageSize" @pagination="getList" />

  </div>
</template>

<script>

import { auditWall, fetchWallList } from '@/api/wall'
import waves from '@/directive/waves' // waves directive
import Pagination from '@/components/Pagination' // secondary package based on el-pagination

export default {
  name: 'ComplexTable',
  components: { Pagination },
  directives: { waves },
  filters: {
    statusFilter(status) {
      const statusMap = {
        0: 'info',
        1: 'success',
        2: 'danger'
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
        adminId: undefined,
        userId: undefined,
        wallId: undefined,
        sort: '+wall_id',
        auditState: undefined
      },
      statusOptions: [{ label: '待审核', key: '0' }, { label: '审核通过', key: '1' }, { label: '审核不通过', key: '2' }],
      sortOptions: [
        { label: 'ID升序', key: '+wall_id' },
        { label: 'ID降序', key: '-wall_id' },
        { label: '审核时间升序', key: '+audit_time' },
        { label: '审核时间降序', key: '-audit_time' }
        // { label: '点赞数升序', key: '+like_num' },
        // { label: '点赞数降序', key: '-like_num' },
        // { label: '评论数升序', key: '+comment_num' },
        // { label: '评论数降序', key: '-comment_num' }
      ],

      rules: {
        type: [{ required: true, message: 'type is required', trigger: 'change' }],
        timestamp: [{ type: 'date', required: true, message: 'timestamp is required', trigger: 'change' }],
        title: [{ required: true, message: 'title is required', trigger: 'blur' }]
      },
      downloadLoading: false
    }
  },
  async created() {
    await this.getList()
  },
  methods: {
    async getList() {
      await fetchWallList(this.listQuery).then(response => {
        this.list = response.data.walls
        console.log(this.list)
        this.list.forEach(function(item) {
          console.log(item)
          if (item.wallImages !== null) {
            const srcArr = item.wallImages.split(',')
            const srcList = []
            srcArr.forEach(function(item1) {
              srcList.push('http://localhost:8086/image/' + item1)
            })
            item.wallImages = srcList
          }
          console.log(item.wallImages)
        })
        this.total = response.data.total
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
      if (prop === 'wallId') {
        this.sortByID(order)
      }
    },
    sortByID(order) {
      if (order === 'ascending') {
        this.listQuery.sort = '+wall_id'
      } else {
        this.listQuery.sort = '-wall_id'
      }
      this.handleFilter()
    },

    handleAudit(row) {
      auditWall({
        wallId: row.wallId,
        auditState: this.auditRadio,
        auditFailedCause: this.auditCause
      }).then(res => {
        console.log(res)
        this.$message.success(res.msg)
        this.$router.go(0)
      })
    },

    handleDownload() {
      this.downloadLoading = true
      import('@/vendor/Export2Excel').then(excel => {
        const tHeader = ['墙ID', '申请人ID', '内容', '图片', '申请时间', '审核状态', '审核人ID', '审核时间']
        const filterVal = ['wallId', 'userId', 'wallContent', 'wallImages', 'createtime', 'auditState', 'adminId', 'auditTime']
        const data = this.formatJson(filterVal)
        excel.export_json_to_excel({
          header: tHeader,
          data,
          filename: 'walls-list'
        })
        this.downloadLoading = false
      })
    },
    formatJson(filterVal) {
      return this.list.map(v => filterVal.map(j => {
        return v[j]
      }))
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
