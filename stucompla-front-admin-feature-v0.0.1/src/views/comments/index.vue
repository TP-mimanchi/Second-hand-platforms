<template>
  <div class="app-container">
    <div class="filter-container">
      <el-input v-model="listQuery.commentId" placeholder="评论ID" style="width: 100px;" class="filter-item" @keyup.enter.native="handleFilter" />
      <el-input v-model="listQuery.postId" placeholder="帖子ID" style="width: 100px;" class="filter-item" @keyup.enter.native="handleFilter" />
      <el-input v-model="listQuery.userId" placeholder="评论人ID" style="width: 150px;" class="filter-item" @keyup.enter.native="handleFilter" />
      <el-input v-model="listQuery.text" placeholder="评论内容" style="width: 150px;" class="filter-item" @keyup.enter.native="handleFilter" />

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
      <el-table-column label="ID" prop="comment_id" sortable="custom" align="center" width="70" :class-name="getSortClass('comment_id')">
        <template slot-scope="{row}">
          <span>{{ row.commentId }}</span>
        </template>
      </el-table-column>
      <el-table-column label="评论内容" align="center">
        <template slot-scope="{row}">
          <span>{{ row.text }}</span>
        </template>
      </el-table-column>
      <el-table-column label="图片" width="125px" align="center">
        <template slot-scope="{row}">
          <el-image
            v-if="row.images!=null&&row.images.length>0"
            style="width: 100px; height: 100px"
            :src="`http://localhost:8086/image/${row.images}`"
          />
          <span v-else>无</span>

        </template>
      </el-table-column>
      <el-table-column label="帖子ID" prop="post_id" sortable="custom" align="center" width="90" :class-name="getSortClass('post_id')">
        <template slot-scope="{row}">
          <span>{{ row.postId }}</span>
        </template>
      </el-table-column>
      <el-table-column label="帖子标题" align="center">
        <template slot-scope="{row}">
          <span>{{ row.postVo.title }}</span>
        </template>
      </el-table-column>
      <el-table-column label="评论人ID" prop="user_id" sortable="custom" align="center" width="120" :class-name="getSortClass('user_id')">
        <template slot-scope="{row}">
          <span>{{ row.userId }}</span>
        </template>
      </el-table-column>
      <el-table-column label="评论时间" align="center" width="155">
        <template slot-scope="{row}">
          <span>{{ row.createTime }}</span>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template slot-scope="{row,$index}">
          <el-popover
            placement="left"
            width="350px"
            trigger="click"
            style="padding-right: 10px"
          >
            <el-input
              v-model="deleteCause"
              placeholder="请输入删除该评论的原因（必填）"
            />
            <p align="center">
              <el-button type="primary" size="mini" @click="deleteComment(row.commentId,$index)">确认删除</el-button>
            </p>
            <el-button slot="reference" type="danger" size="mini">删除评论</el-button>

          </el-popover>

        </template>
      </el-table-column>
    </el-table>

    <pagination v-show="total>0" :total="total" :page.sync="listQuery.pageNum" :limit.sync="listQuery.pageSize" @pagination="getList" />

  </div>
</template>

<script>
import { fetchCategoryList } from '@/api/category'
import waves from '@/directive/waves' // waves directive
import Pagination from '@/components/Pagination'
import { deleteComment, fetchCommentList } from '@/api/comment' // secondary package based on el-pagination

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
        commentId: undefined,
        postId: undefined,
        userId: undefined,
        text: undefined,
        sort: '-comment_id'
      },
      deleteCause: undefined,
      categories: [],
      roleOptions: [{ label: 'admin', key: '2' }, { label: 'super', key: '3' }],
      sortOptions: [{ label: 'ID升序', key: '+comment_id' },
        { label: 'ID降序', key: '-comment_id' },
        { label: '帖子ID升序', key: '+post_id' },
        { label: '帖子ID降序', key: '-post_id' },
        { label: '发布人ID升序', key: '+user_id' },
        { label: '发布人ID降序', key: '-user_id' }],
      statusOptions: [{ label: '锁定', key: 1 }, { label: '正常', key: 0 }]
    }
  },
  async created() {
    await this.getList()
    await this.getCategoryList()
  },
  methods: {
    async getList() {
      console.log('nsgio13241464')
      await fetchCommentList(this.listQuery).then(response => {
        this.list = response.data.commentList
        this.total = response.data.total
      })
      this.listLoading = false
      console.log('bbbb1')
    },
    handleFilter() {
      this.listQuery.pageNum = 1
      this.getList()
    },

    deleteComment(commentId, index) {
      deleteComment({ commentId: commentId, cause: this.deleteCause }).then(res => {
        this.$message.success(res.data)
        this.list.splice(index, 1)
        this.$router.go(0)
      })
    },
    sortChange(data) {
      const { prop, order } = data
      if (prop === 'comment_id') {
        this.sortByID(order)
      }
      if (prop === 'post_id') {
        this.sortByPostId(order)
      }
      if (prop === 'user_id') {
        this.sortByUserId(order)
      }
    },
    sortByID(order) {
      if (order === 'ascending') {
        this.listQuery.sort = '+comment_id'
      } else {
        this.listQuery.sort = '-comment_id'
      }
      this.handleFilter()
    },
    sortByPostId(order) {
      if (order === 'ascending') {
        this.listQuery.sort = '+post_id'
      } else {
        this.listQuery.sort = '-post_id'
      }
      this.handleFilter()
    },
    sortByUserId(order) {
      if (order === 'ascending') {
        this.listQuery.sort = '+user_id'
      } else {
        this.listQuery.sort = '-user_id'
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
    getSortClass: function(key) {
      const sort = this.listQuery.sort
      return sort === `+${key}` ? 'ascending' : 'descending'
    },
    async getCategoryList() {
      console.log('aaaaa1')
      await fetchCategoryList().then(response => {
        console.log(response)
        console.log('mo11001010110100101')
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
