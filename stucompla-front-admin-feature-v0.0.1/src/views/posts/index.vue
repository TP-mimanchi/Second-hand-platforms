<template>
  <div class="app-container">
    <div class="filter-container">
      <el-input v-model="listQuery.postId" placeholder="ID" style="width: 100px;" class="filter-item" @keyup.enter.native="handleFilter" />
      <el-input v-model="listQuery.title" placeholder="标题" style="width: 150px;" class="filter-item" @keyup.enter.native="handleFilter" />
      <el-input v-model="listQuery.detail" placeholder="内容" style="width: 150px;" class="filter-item" @keyup.enter.native="handleFilter" />
      <el-input v-model="listQuery.userId" placeholder="发布人ID" style="width: 150px;" class="filter-item" @keyup.enter.native="handleFilter" />

      <!-- 发布人 种类-->
      <el-select v-model="listQuery.categoryId" placeholder="种类" clearable style="width: 120px" class="filter-item" @change="handleFilter">
        <el-option v-for="item in categories" :key="item.categoryId" :label="item.categoryName" :value="item.categoryId" />
      </el-select>
      <el-select v-model="listQuery.postStatus" placeholder="状态" clearable style="width: 140px" class="filter-item" @change="handleFilter">
        <el-option v-for="item in statusOptions" :key="item.key" :label="item.label" :value="item.key" />
      </el-select>
      <el-select v-model="listQuery.sort" style="width: 140px" class="filter-item" @change="handleFilter">
        <el-option v-for="item in sortOptions" :key="item.key" :label="item.label" :value="item.key" />
      </el-select>
      <el-button v-waves class="filter-item" type="primary" icon="el-icon-search" @click="handleFilter">
        搜索
      </el-button>
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
      <el-table-column label="ID" prop="post_id" sortable="custom" align="center" width="70" :class-name="getSortClass('post_id')">
        <template slot-scope="{row}">
          <span>{{ row.postId }}</span>
        </template>
      </el-table-column>
      <el-table-column label="标题" align="center">
        <template slot-scope="{row}">
          <span>{{ row.title }}</span>
        </template>
      </el-table-column>
      <el-table-column label="种类" width="90px" align="center">
        <template slot-scope="{row}">
          <span>{{ row.category.categoryName }}</span>
        </template>
      </el-table-column>
      <el-table-column label="内容" align="center" width="105" class-name="small-padding fixed-width">
        <template slot-scope="{row}">
          <el-button type="primary" size="mini" @click="handleDetailView(row)">
            查看内容
          </el-button>
        </template>
      </el-table-column>
      <el-table-column label="发贴人" width="90px" align="center">
        <template slot-scope="{row}">
          <span>{{ row.user.username }}</span>
        </template>
      </el-table-column>

      <el-table-column label="浏览量" prop="view_num" sortable="custom" align="center" width="90" :class-name="getSortClass('view_num')">
        <template slot-scope="{row}">
          <span>{{ row.viewNum }}</span>
        </template>
      </el-table-column>
      <el-table-column label="评论数" prop="comment_num" sortable="custom" align="center" width="90" :class-name="getSortClass('comment_num')">
        <template slot-scope="{row}">
          <span>{{ row.commentNum }}</span>
        </template>
      </el-table-column>

      <el-table-column label="发帖时间" align="center" width="155">
        <template slot-scope="{row}">
          <span>{{ row.createTime }}</span>
        </template>
      </el-table-column>

      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template slot-scope="{row,$index}">
          <el-popover
            v-if="row.postStatus==0"
            placement="left"
            width="350px"
            trigger="click"
            style="padding-right: 10px"
          >
            <el-input
              v-model="lockedCause"
              placeholder="请输入锁定原因（必填）"
            />
            <p align="center">
              <el-button type="primary" size="mini" @click="handleModifyStatus(row,true)">确认锁定</el-button>
            </p>
            <el-button slot="reference" type="warning" size="mini">锁定</el-button>

          </el-popover>
          <el-popconfirm
            v-else
            placement="top"
            style="padding-right: 10px"
            confirm-button-text="确定"
            cancel-button-text="取消"
            icon="el-icon-info"
            icon-color="red"
            title="确定解锁该帖子吗？"
            @onConfirm="handleModifyStatus(row,false)"
          >
            <el-button slot="reference" size="mini" type="success">
              解锁
            </el-button>
          </el-popconfirm>
          <el-popover
            placement="left"
            width="350px"
            trigger="click"
            style="padding-right: 10px"
          >
            <h3 style="color:red;">删除后所有相关数据将丢失，此操作不可恢复！谨慎操作！</h3>
            <el-input
              v-model="deleteCause"
              placeholder="请输入删除原因（必填）"
            />
            <p align="center">
              <el-button type="primary" size="mini" @click="deletePost(row.postId,$index)">确认删除</el-button>
            </p>
            <el-button slot="reference" type="danger" size="mini">删除</el-button>

          </el-popover>

        </template>
      </el-table-column>
    </el-table>

    <pagination v-show="total>0" :total="total" :page.sync="listQuery.pageNum" :limit.sync="listQuery.pageSize" @pagination="getList" />
    <el-dialog :visible.sync="dialogDetailVisible" title="帖子详情">
      <div class="postStyle" v-html="postDetail" />
    </el-dialog>
  </div>
</template>

<script>
import { fetchCategoryList } from '@/api/category'
import { deletePostByAdmin, fetchPostList, lockedPost, unLockPost } from '@/api/post'
import waves from '@/directive/waves' // waves directive
import Pagination from '@/components/Pagination' // secondary package based on el-pagination

export default {
  name: 'ComplexTable',
  components: { Pagination },
  directives: { waves },
  filters: {
    statusFilter(status) {
      const statusMap = {
        published: 'success',
        draft: 'info',
        deleted: 'danger'
      }
      return statusMap[status]
    }

  },
  data() {
    return {
      tableKey: 0,
      list: null,
      total: 0,
      listLoading: true,
      listQuery: {
        pageNum: 1,
        pageSize: 20,
        postId: undefined,
        title: undefined,
        detail: undefined,
        userId: undefined,
        categoryId: undefined,
        postStatus: undefined,
        sort: '+post_id'
      },
      lockedCause: undefined,
      deleteCause: undefined,
      categories: [],
      roleOptions: [{ label: 'admin', key: '2' }, { label: 'super', key: '3' }],
      sortOptions: [{ label: 'ID升序', key: '+post_id' },
        { label: 'ID降序', key: '-post_id' },
        { label: 'PV升序', key: '+view_num' },
        { label: 'PV降序', key: '-view_num' },
        { label: '评论数升序', key: '+comment_num' },
        { label: '评论数降序', key: '-comment_num' }],
      statusOptions: [{ label: '锁定', key: 1 }, { label: '正常', key: 0 }],

      postDetail: undefined,
      dialogDetailVisible: false,

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
    await this.getCategoryList()
  },
  methods: {
    async getList() {
      await fetchPostList(this.listQuery).then(response => {
        console.log(response)
        this.list = response.data.postList
        this.total = response.data.total
        this.listLoading = false
      })
    },
    handleFilter() {
      this.listQuery.pageNum = 1
      this.getList()
    },
    handleModifyStatus(row, status) {
      if (status) {
        lockedPost({ postId: row.postId, cause: this.lockedCause }).then(res => {
          this.$message.success(res.data)
          row.postStatus = 1
        })
      } else {
        unLockPost({ postId: row.postId }).then(res => {
          this.$message.success(res.data)
          row.postStatus = 0
        })
      }
    },
    deletePost(postId, index) {
      deletePostByAdmin({ postId: postId, cause: this.deleteCause }).then(res => {
        this.$message.success(res.data)
        this.list.splice(index, 1)
        this.$router.go(0)
      })
    },
    sortChange(data) {
      const { prop, order } = data
      if (prop === 'post_id') {
        this.sortByID(order)
      }
      if (prop === 'view_num') {
        this.sortByPV(order)
      }
      if (prop === 'comment_num') {
        this.sortByCommentNum(order)
      }
    },
    sortByID(order) {
      if (order === 'ascending') {
        this.listQuery.sort = '+post_id'
      } else {
        this.listQuery.sort = '-post_id'
      }
      this.handleFilter()
    },
    sortByPV(order) {
      if (order === 'ascending') {
        this.listQuery.sort = '+view_num'
      } else {
        this.listQuery.sort = '-view_num'
      }
      this.handleFilter()
    },
    sortByCommentNum(order) {
      if (order === 'ascending') {
        this.listQuery.sort = '+comment_num'
      } else {
        this.listQuery.sort = '-comment_num'
      }
      this.handleFilter()
    },

    handleDetailView(row) {
      this.postDetail = row.detail
      this.dialogDetailVisible = true
    },

    handleDownload() {
      this.downloadLoading = true
      import('@/vendor/Export2Excel').then(excel => {
        const tHeader = ['帖子ID', '标题', '种类Id', '种类', '内容', '发帖人ID', '发帖人', '浏览量', '评论数', '发帖时间']
        const filterVal = ['postId', 'title', 'categoryId', 'categoryName', 'detail', 'userId', 'username', 'viewNum', 'commentNum', 'createTime']
        const data = this.formatJson(filterVal)
        excel.export_json_to_excel({
          header: tHeader,
          data,
          filename: 'post-list'
        })
        this.downloadLoading = false
      })
    },
    formatJson(filterVal) {
      return this.list.map(v => filterVal.map(j => {
        if (j === 'categoryId') {
          return v['category'].categoryId
        } else if (j === 'categoryName') {
          return v['category'].categoryName
        } else if (j === 'username') {
          return v['user'].username
        } else if (j === 'userId') {
          return v['user'].userId
        } else {
          return v[j]
        }
      }))
    },
    getSortClass: function(key) {
      const sort = this.listQuery.sort
      return sort === `+${key}` ? 'ascending' : 'descending'
    },
    getCategoryList() {
      fetchCategoryList().then(response => {
        console.log(response)
        response.data.forEach(item => {
          const arr = {
            categoryId: item.categoryId,
            categoryName: item.categoryName
          }
          this.categories.push(arr)
        })
      })
    }
  }
}
</script>
<style  lang="less" scoped>

//帖子详情的样式
.postStyle {
/* table 样式 */
/deep/ table {border-top: 1px solid #ccc;
  border-left: 1px solid #ccc;
}
/deep/ table td,
/deep/ table th {
  border-bottom: 1px solid #ccc;
  border-right: 1px solid #ccc;
  padding: 3px 5px;
}
/deep/ table th {border-bottom: 2px solid #ccc;text-align: center;}
/* blockquote 样式 */
/deep/  blockquote {
  display: block;border-left: 8px solid #d0e5f2;padding: 5px 10px;
  margin: 10px 0;line-height: 1.4;font-size: 100%;background-color: #f1f1f1;}
/* code 样式 */
/deep/ code {
  display: inline-block;
  *display: inline;
  *zoom: 1;
  background-color: #f1f1f1;
  border-radius: 3px;
  padding: 3px 5px;
  margin: 0 3px;
}
/deep/ pre code {
  display: block;
}

/* ul ol 样式 */
/deep/ ul, ol {
  margin: 10px 0 10px 20px;
}
}
</style>
