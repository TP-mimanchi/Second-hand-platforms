<template>
  <div class="app-container">
    <div class="filter-container">
      <el-input v-model="listQuery.userId" placeholder="ID" style="width: 100px;" class="filter-item" @keyup.enter.native="handleFilter" />
      <el-input v-model="listQuery.username" placeholder="用户名" style="width: 200px;" class="filter-item" @keyup.enter.native="handleFilter" />
      <el-select v-model="listQuery.sex" placeholder="性别" clearable style="width: 90px" class="filter-item" @change="handleFilter">
        <el-option v-for="item in sexOptions" :key="item" :label="item" :value="item" />
      </el-select>
      <el-select v-model="listQuery.status" placeholder="状态" clearable style="width: 140px" class="filter-item" @change="handleFilter">
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
      <el-table-column label="ID" prop="id" sortable="custom" align="center" width="80" :class-name="getSortClass('id')">
        <template slot-scope="{row}">
          <span>{{ row.userId }}</span>
        </template>
      </el-table-column>
      <el-table-column label="用户名" width="110px" align="center">
        <template slot-scope="{row}">
          <span>{{ row.username }}</span>
        </template>
      </el-table-column>
      <el-table-column label="性别" width="50px" align="center">
        <template slot-scope="{row}">
          <span>{{ row.sex }}</span>
        </template>
      </el-table-column>
      <el-table-column label="头像" width="125px" align="center">
        <template slot-scope="{row}">
          <el-image
            v-if="row.avatar!=null&&row.avatar.length>0"
            style="width: 100px; height: 100px"
            :src="`http://localhost:8086/image/${row.avatar}`"
          />
          <span v-else>未上传</span>
        </template>
      </el-table-column>
      <el-table-column label="个性签名" align="left">
        <template slot-scope="{row}">
          <el-tooltip class="item" :content="row.signature" placement="bottom" effect="light">
            <span class="span-single-show">{{ row.signature }}</span>
          </el-tooltip>
        </template>
      </el-table-column>
      <el-table-column label="注册时间" width="180px" align="center">
        <template slot-scope="{row}">
          <span>{{ row.createtime }}</span>
        </template>
      </el-table-column>

      <el-table-column label="状态" class-name="status-col" width="100" align="center">
        <template slot-scope="{row}">
          <el-tag :type="row.locked | statusFilter">
            {{ row.locked?'锁定':'正常' }}
          </el-tag>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template slot-scope="{row}">
          <el-popover
            placement="left"
            width="350px"
            align="center"
            trigger="click"
            style="padding-right: 10px"
          >
            <h3 align="center">重置 {{ row.username }} 的密码</h3>
            <el-form
              label-position="right"
              label-width="90px"
              :model="changePwdForm"
            >
              <el-form-item label="新密码">
                <el-input v-model="changePwdForm.newPassword" type="password" />
              </el-form-item>
              <el-form-item label="重复新密码">
                <el-input v-model="changePwdForm.secondPassword" type="password" />
              </el-form-item>
              <el-form-item>
                <el-button type="primary" plain @click="changePwd(row.userId)">确定重置</el-button>
              </el-form-item>
            </el-form>
            <el-button slot="reference" type="primary" size="mini">
              重置密码
            </el-button>
          </el-popover>
          <el-popover
            v-if="!row.locked"
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
            title="确定解锁该用户吗？"
            @onConfirm="handleModifyStatus(row,false)"
          >
            <el-button slot="reference" size="mini" type="success">
              解锁
            </el-button>
          </el-popconfirm>

        </template>
      </el-table-column>
    </el-table>

    <pagination v-show="total>0" :total="total" :page.sync="listQuery.pageNum" :limit.sync="listQuery.pageSize" @pagination="getList" />

  </div>
</template>

<script>
import { fetchList, changeUserPwd, lockedUser, unLockUser } from '@/api/user'
import waves from '@/directive/waves' // waves directive
import Pagination from '@/components/Pagination' // secondary package based on el-pagination

export default {
  name: 'ComplexTable',
  components: { Pagination },
  directives: { waves },
  filters: {
    statusFilter(status) {
      const statusMap = {
        true: 'danger',
        false: 'success',
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
        userId: undefined,
        username: undefined,
        email: undefined,
        sex: undefined,
        status: undefined,
        sort: '+id'
      },
      lockedCause: undefined,
      changePwdForm: {
        newPassword: undefined,
        secondPassword: undefined,
        userId: undefined
      },
      sexOptions: ['男', '女'],
      sortOptions: [{ label: 'ID升序', key: '+id' }, { label: 'ID降序', key: '-id' }],
      statusOptions: [{ label: '锁定', key: 1 }, { label: '正常', key: 0 }]
    }
  },
  async created() {
    await this.getList()
  },
  methods: {
    async getList() {
      await fetchList(this.listQuery).then(response => {
        this.list = response.data.userList
        this.total = response.data.total
        this.listLoading = false
      })
    },
    async changePwd(userId) {
      this.changePwdForm.userId = userId
      await changeUserPwd(this.changePwdForm).then(res => {
        this.$message.success(res.data)
        this.$router.go(0)
      })
    },
    handleFilter() {
      this.listQuery.pageNum = 1
      this.getList()
    },
    handleModifyStatus(row, status) {
      if (status) {
        lockedUser({ userId: row.userId, cause: this.lockedCause }).then(res => {
          this.$message.success(res.data)
          row.locked = status
        })
      } else {
        unLockUser({ userId: row.userId }).then(res => {
          this.$message.success(res.data)
          row.locked = status
        })
      }
    },
    sortChange(data) {
      const { prop, order } = data
      if (prop === 'id') {
        this.sortByID(order)
      }
    },
    sortByID(order) {
      if (order === 'ascending') {
        this.listQuery.sort = '+id'
      } else {
        this.listQuery.sort = '-id'
      }
      this.handleFilter()
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
