<template>
  <div class="app-container">
    <div class="filter-container">
      <el-input v-model="listQuery.adminId" placeholder="ID" style="width: 100px;" class="filter-item" @keyup.enter.native="handleFilter" />
      <el-input v-model="listQuery.username" placeholder="用户名" style="width: 180px;" class="filter-item" @keyup.enter.native="handleFilter" />
      <el-select v-model="listQuery.roleId" placeholder="角色" clearable style="width: 90px" class="filter-item" @change="handleFilter">
        <el-option v-for="item in roleOptions" :key="item.key" :label="item.label" :value="item.key" />
      </el-select>
      <el-select v-model="listQuery.sort" style="width: 140px" class="filter-item" @change="handleFilter">
        <el-option v-for="item in sortOptions" :key="item.key" :label="item.label" :value="item.key" />
      </el-select>
      <el-button v-waves class="filter-item" type="primary" icon="el-icon-search" @click="handleFilter">
        搜索
      </el-button>
      <el-button class="filter-item" style="margin-left: 10px;" type="primary" icon="el-icon-edit" @click="dialogAddVisible=true">
        添加
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
          <span>{{ row.adminId }}</span>
        </template>
      </el-table-column>
      <el-table-column label="用户名" width="110px" align="center">
        <template slot-scope="{row}">
          <span>{{ row.username }}</span>
        </template>
      </el-table-column>
      <el-table-column label="角色" width="110px" align="center">
        <template slot-scope="{row}">
          <span>{{ row.roleId==3?'super':'admin' }}</span>
        </template>
      </el-table-column>
      <el-table-column label="Date" width="180px" align="center">
        <template slot-scope="{row}">
          <span>{{ row.createTime }}</span>
        </template>
      </el-table-column>
      <el-table-column label="Actions" align="center" width="230" class-name="small-padding fixed-width">
        <template slot-scope="{row}">
          <el-popover
            placement="left"
            title="修改角色"
            width="240"
            trigger="click"
          >
            <div style="text-align: center">
              <p>
                <el-select v-model="changeRoleValue" placeholder="请选择">
                  <el-option
                    v-for="item in options"
                    :key="item.value"
                    :label="item.label"
                    :value="item.value"
                  />
                </el-select>
              </p>

              <p style="">
                <el-button size="mini" type="primary" @click="changeRole(row)">
                  确定
                </el-button>
              </p>
            </div>
            <el-button slot="reference" size="mini" type="primary">
              修改角色
            </el-button>
          </el-popover>
          <el-popover
            placement="left"
            width="350px"
            trigger="click"
            style="margin-left: 10px"
          >
            <h4 style="color:red;">此操作不可恢复！谨慎操作！</h4>
            <p align="center">
              <el-button type="primary" size="mini" @click="deleteAdmin(row.adminId)">确认删除</el-button>
            </p>
            <el-button slot="reference" type="danger" size="mini">删除</el-button>
          </el-popover>

        </template>
      </el-table-column>
    </el-table>

    <pagination v-show="total>0" :total="total" :page.sync="listQuery.pageNum" :limit.sync="listQuery.pageSize" @pagination="getList" />

    <el-dialog
      title="添加管理员"
      :visible.sync="dialogAddVisible"
      :modal-append-to-body="false"
      :lock-scroll="false"
      width="25%"
      :center="true"
      :show-close="false"
    >
      <el-form :model="AddForm">
        <el-form-item label="">
          <el-input v-model="AddForm.username" placeholder="用户名" prefix-icon="el-icon-user" />
        </el-form-item>
        <el-form-item label="">
          <el-input v-model="AddForm.password" type="password" placeholder="密码" prefix-icon="el-icon-lock" />
        </el-form-item>
        <el-form-item label="">
          <el-select v-model="AddForm.roleId" placeholder="请选择角色">
            <el-option v-for="item in options" :key="item.value" :label="item.label" :value="item.value" />
          </el-select>
        </el-form-item>
        <el-form-item align="center">
          <el-button type="danger" @click="handleAdd()">添加</el-button>
        </el-form-item>
      </el-form>
    </el-dialog>
  </div>
</template>

<script>
import { fetchList, changeRole, deleteAdmin, addAdmin } from '@/api/admin'
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
      AddForm: {
        username: undefined,
        password: undefined,
        roleId: '2'
      },
      listQuery: {
        pageNum: 1,
        pageSize: 20,
        adminId: undefined,
        username: undefined,
        roleId: undefined,
        sort: '+id'
      },
      dialogAddVisible: false,
      options: [{
        value: '2',
        label: 'admin'
      }, {
        value: '3',
        label: 'super'
      }],
      changeRoleValue: '2',
      roleOptions: [{ label: 'admin', key: '2' }, { label: 'super', key: '3' }],

      sortOptions: [{ label: 'ID升序', key: '+id' }, { label: 'ID降序', key: '-id' }]

    }
  },
  async  created() {
    await this.getList()
  },
  methods: {
    getRole(roleId) {
      if (roleId === 2) {
        return 'admin'
      } else if (roleId === 3) {
        return 'super'
      }
    },
    async getList() {
      await fetchList(this.listQuery).then(response => {
        console.log(response)
        this.list = response.data.adminList
        this.total = response.data.total
        console.log(this.list)
        this.listLoading = false
      })
      // fetchList(this.listQuery).then(response => {
      //   this.list = response.data.items
      //   this.total = response.data.total
      //
      //   // Just to simulate the time of the request
      //   setTimeout(() => {
      //     this.listLoading = false
      //   }, 1.5 * 1000)
      // })
    },
    async changeRole(row) {
      await changeRole({ roleId: this.changeRoleValue, adminId: row.adminId }).then(res => {
        this.$message.success(res.data)
        this.$router.go(0)
      })
    },
    async deleteAdmin(adminId) {
      await deleteAdmin({ adminId: adminId }).then(res => {
        this.$router.go(0)
        this.$message.success(res.data)
      })
    },
    async handleAdd() {
      await addAdmin(this.AddForm).then(res => {
        this.$router.go(0)
        this.$message.success(res.data)
      })
    },
    handleFilter() {
      this.listQuery.pageNum = 1
      this.getList()
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
