<template>
  <div class="account">
    <h1>账号设置</h1>
    <ul>
      <!-- <li>
        <span class="phone">手机号</span>
        <span class="set" @click="handlePhoneClick"> <svg viewBox="64 64 896 896" data-icon="plus" width="1em"
            height="1em" fill="currentColor" aria-hidden="true" focusable="false" class="">
            <path d="M482 152h60q8 0 8 8v704q0 8-8 8h-60q-8 0-8-8V160q0-8 8-8z"></path>
            <path d="M176 474h672q8 0 8 8v60q0 8-8 8H176q-8 0-8-8v-60q0-8 8-8z"></path>
          </svg>绑定手机</span>

      </li> -->
      <li>
        <span class="邮箱">邮箱</span>
        <span v-if="!userInfo.email" class="set" @click="handleEmailClick">
          <svg
            viewBox="64 64 896 896"
            data-icon="plus"
            width="1em"
            height="1em"
            fill="currentColor"
            aria-hidden="true"
            focusable="false"
            class=""
          >
            <path
              d="M482 152h60q8 0 8 8v704q0 8-8 8h-60q-8 0-8-8V160q0-8 8-8z"
            ></path>
            <path
              d="M176 474h672q8 0 8 8v60q0 8-8 8H176q-8 0-8-8v-60q0-8 8-8z"
            ></path></svg
          >绑定邮箱</span
        >
        <div class="hasEmail" v-else>
          <span>{{ userInfo.email }}</span>
          <el-popconfirm
            title="你确定要解绑邮箱吗?"
            confirm-button-text="确定"
            cancel-button-text="取消"
            @confirm="unbindingEmail"
          >
            <template #reference>
              <el-button type="warning" size="small">解绑</el-button>
            </template>
          </el-popconfirm>
        </div>
      </li>
      <li>
        <span class="密码">密码</span>
        <span>**************</span>
        <el-button type="primary" size="small" @click="handleChangeClick"
          >修改</el-button
        >
      </li>
    </ul>

    <!-- 手机验证码  -->
    <el-dialog v-model="phoneDialogVisible" title="绑定手机" width="30%">
      <el-row :gutter="20">
        <el-col :span="16">
          <el-input type="text" placeholder="手机号" v-model="phone"></el-input>
        </el-col>
        <el-col :span="8">
          <el-button>获取验证码</el-button>
        </el-col>
      </el-row>
      <template #footer>
        <span class="dialog-footer">
          <el-button type="primary" @click=""> 绑定 </el-button>
        </span>
      </template>
    </el-dialog>

    <!-- 邮箱证码  -->
    <el-dialog v-model="emailDialogVisible" title="绑定邮箱" width="30%">
      <el-row :gutter="20">
        <el-col :span="16">
          <el-input type="text" placeholder="邮箱" v-model="email"></el-input>
        </el-col>
        <el-col :span="8">
          <send-code :email="email"></send-code>
        </el-col>
      </el-row>
      <el-row :gutter="20" style="margintop: 10px">
        <el-col :span="16">
          <el-input type="text" placeholder="验证码" v-model="code"></el-input>
        </el-col>
      </el-row>
      <template #footer>
        <span class="dialog-footer">
          <el-button type="primary" @click="bindingEmail"> 绑定 </el-button>
        </span>
      </template>
    </el-dialog>

    <!-- 更改密码  -->
    <el-dialog v-model="passwordDialogVisible" title="更改密码" width="30%">
      <el-form
        :inline="true"
        :model="pwd"
        label-width="100px"
        label-position="left"
        style="width: 100%"
      >
        <el-form-item label="旧密码:" style="width: 100%">
          <el-input
            v-model="pwd.oldPassword"
            placeholder="旧密码"
            type="password"
            show-password
          />
        </el-form-item>
        <el-form-item label="新密码: " style="width: 100%">
          <el-input
            v-model="pwd.newPassword"
            placeholder="新密码"
            type="password"
            show-password
          />
        </el-form-item>
        <el-form-item label="确认密码:" style="width: 100%">
          <el-input
            v-model="pwd.verifyPassword"
            placeholder="确认密码"
            type="password"
            show-password
          />
        </el-form-item>
      </el-form>

      <template #footer>
        <span class="dialog-footer">
          <el-button type="primary" @click="changePassword"> 修改 </el-button>
        </span>
      </template>
    </el-dialog>
  </div>
</template>

<script lang="ts" setup>
import { reactive, ref } from 'vue'
import { useUserStore } from '@/stores/userStore'
import { unbindingEmailAPi, updateEmail, updatePassword } from '@/api/user'
import { ElMessage } from 'element-plus'
import SendCode from '@/components/Ui/SendCode/SendCode.vue'

const userStore = useUserStore()

const userInfo = userStore.userInfo

//绑定手机验证码
const phoneDialogVisible = ref(false)
const phone = ref<number>(null)

//手机验证码
const emailDialogVisible = ref(false)
const email = ref<string>(null)
const code = ref<string>(null)

//手机验证码
const passwordDialogVisible = ref(false)
const pwd = reactive({
  oldPassword: '',
  newPassword: '',
  verifyPassword: ''
})

const handlePhoneClick = () => {
  phoneDialogVisible.value = true
}

const handleEmailClick = () => {
  emailDialogVisible.value = true
}

const handleChangeClick = () => {
  passwordDialogVisible.value = true
}

//解绑邮箱
const unbindingEmail = async () => {
  const res: any = await unbindingEmailAPi()

  if (res.code === 200) {
    ElMessage({
      message: '解绑成功！',
      type: 'success'
    })
    userInfo.email = null
  }
}

const bindingEmail = async () => {
  const res: any = await updateEmail(email.value, code.value)
  console.log(res)

  if (res.code === 200) {
    ElMessage({
      message: '绑定成功！',
      type: 'success'
    })
    userInfo.email = email.value
  } else {
    ElMessage({
      message: res.msg,
      type: 'warning'
    })
  }
  emailDialogVisible.value = false
}

//改变密码
const changePassword = async () => {
  if (
    (pwd.newPassword == '', pwd.oldPassword == '', pwd.verifyPassword == '')
  ) {
    ElMessage({
      message: '输入不能为空',
      type: 'warning'
    })
    return
  }

  if (pwd.newPassword === pwd.verifyPassword) {
    let res: any = await updatePassword(pwd.oldPassword, pwd.newPassword)

    if (res.code === 200) {
      ElMessage({
        message: res.data,
        type: 'success'
      })
    } else {
      ElMessage({
        message: res.msg,
        type: 'warning'
      })
    }
  } else {
    ElMessage({
      type: 'warning',
      message: '新密码和确定密码不相同'
    })
  }
}
</script>

<style scoped lang="scss">
.account {
  width: 100%;
  padding: 20px;

  h1 {
    font-size: 20px;
    padding-bottom: 20px;
    border-bottom: 1px solid var(--theme-border3-color);
  }

  ul {
    li {
      & > span:first-child {
        width: 160px;
        margin-left: 10px;
      }

      display: flex;
      height: 70px;
      align-items: center;
      border-bottom: 1px solid var(--theme-border3-color);

      .set {
        display: flex;
        align-items: center;
        color: var(--theme-text-active-color);
        cursor: pointer;
      }

      button {
        margin-left: 20px;
      }
    }
  }
}
</style>
