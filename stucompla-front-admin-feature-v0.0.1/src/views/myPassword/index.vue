<template>
  <el-row>
    <el-col :span="6" :offset="5">
      <el-card>
        <el-form
          ref="basicInfo"
          :rules="basicInfoRules"
          label-position="right"
          label-width="80px"
          :model="changeUserName"
        >
          <h3 align="center">修改用户名</h3>

          <el-form-item
            label="用户名"
            prop="username"
          >
            <el-input v-model="changeUserName.username" @keyup.enter.native="changeUsername" />
          </el-form-item>
          <el-form-item>
            <el-button
              type="primary"
              plain
              round
              size="small"
              @click="changeUsername"
            >
              确认修改
            </el-button>
          </el-form-item>
        </el-form>
      </el-card>
    </el-col>
    <el-col :span="8" :offset="1">
      <el-card>
        <el-form
          ref="changePwd"
          :rules="changePwdRules"
          label-position="right"
          label-width="80px"
          :model="changePwdForm"
        >
          <h3 align="center">修改密码</h3>
          <el-form-item
            label="旧密码"
            prop="oldPassword"
          >
            <el-input v-model="changePwdForm.oldPassword" type="password" />
          </el-form-item>
          <el-form-item
            label="新密码"
            prop="inPassword"
          >
            <el-input v-model="changePwdForm.inPassword" type="password" />
          </el-form-item>
          <el-form-item
            label="重复密码"
            prop="secondPassword"
          >
            <el-input v-model="changePwdForm.secondPassword" type="password" @keyup.enter.native="changePwd" />
          </el-form-item>
          <el-form-item>
            <el-button
              type="primary"
              plain
              round
              size="small"
              @click="changePwd"
            >
              确认修改
            </el-button>
          </el-form-item>
        </el-form>
      </el-card>
    </el-col>
  </el-row>
</template>
<script>
import { changeMyPwd, changeMyUsername } from '@/api/admin'
import { mapGetters } from 'vuex'

export default {
  name: 'MyPassword',
  data() {
    const validateUsername = (rule, value, callback) => {
      if (value.length < 3 || value.length > 10) {
        callback(new Error('用户名长度在3-10位'))
      } else {
        callback()
      }
    }
    const validatePassword = (rule, value, callback) => {
      if (value.length < 6 || value.length > 16) {
        callback(new Error('密码长度在6-16位'))
      } else {
        callback()
      }
    }
    return {
      changePwdForm: {
        oldPassword: '',
        inPassword: '',
        secondPassword: ''
      },
      changePwdRules: {
        oldPassword: [{ required: true, trigger: 'blur', message: '请输入旧密码' }],
        inPassword: [{ required: true, trigger: 'blur', message: '密码长度在6-16位', validator: validatePassword }],
        secondPassword: [{ required: true, trigger: 'blur', message: '密码长度在6-16位', validator: validatePassword }]
      },
      changeUserName: {
        username: this.$store.state.user.name
      },
      basicInfoRules: {
        username: [{ required: true, trigger: 'blur', validator: validateUsername }]
      }
    }
  },
  methods: {
    async changeUsername() {
      await this.$refs.basicInfo.validate(valid => {
        if (valid) {
          changeMyUsername(this.changeUserName).then(res => {
            this.$message.success('修改成功')
          })
        } else {
          return false
        }
      })
    },
    async changePwd() {
      await this.$refs.changePwd.validate(valid => {
        if (valid) {
          changeMyPwd(this.changePwdForm).then(res => {
            this.$message.success('修改成功，请重新登录')
            this.$store.dispatch('user/logout').then(res => {
              this.$router.push(`/login?redirect=${this.$route.fullPath}`)
            })
          })
        } else {
          return false
        }
      })
    }
  }
}
</script>

<style scoped>

</style>
