<template>
  <div class="myheader">
    <div class="content">
      <div class="myheader-left">
        <div class="logo">遥宇</div>
        <my-menu :menu-list="menuList" :route="true"></my-menu>
      </div>
      <div class="myheader-right">
        <div class="search">
          <el-input placeholder="搜索" :suffix-icon="Search"></el-input>
        </div>

        <i class="iconfont icon-bell notification"></i>

        <!-- <el-switch
          v-model="theme"
          class="mt-2"
          style="margin-left: 24px"
          inline-prompt
          :active-icon="Check"
          :inactive-icon="Close"
        /> -->
        <el-button
          v-if="!userStore.token"
          type="primary"
          plain
          @click="loginClick"
          >登录/注册</el-button
        >
        <div v-else class="userinfo">
          <el-dropdown>
            <el-avatar
              :size="30"
              :src="userStore.userInfo ? userStore.userInfo.avatar : ''"
            />
            <el-avatar></el-avatar>
            <template #dropdown>
              <el-dropdown-menu>
                <el-dropdown-item @click="toUserInfo">
                  <i class="iconfont icon-user-picture"></i>个人主页
                </el-dropdown-item>
                <el-dropdown-item divided @click="toSetting">
                  <i class="iconfont icon-setUp"></i>设置
                </el-dropdown-item>
                <el-dropdown-item divided @click="toManagement">
                  <el-icon><Grid /></el-icon> 管理端
                  <!-- <i class="iconfont icon-setUp"></i>管理端 -->
                </el-dropdown-item>
                <el-dropdown-item divided @click="handleLogout">
                  <i class="iconfont icon-quit"></i>退出登录
                </el-dropdown-item>
              </el-dropdown-menu>
            </template>
          </el-dropdown>
        </div>
      </div>
    </div>
  </div>
</template>

<script lang="ts" setup>
import { reactive, ref } from 'vue'
import { Check, Close, Search } from '@element-plus/icons-vue'
import MyMenu from '@/components/common/menu.vue'
import { usescrollStore } from '@/stores/useScroll'
import { useUserStore } from '@/stores/userStore'
import { logout } from '@/api/login'
import { useRouter, useRoute } from 'vue-router'

let theme = ref<string>('light')
const userStore = useUserStore()
type Menu = {
  menuname: string
  path: string
  active: boolean
}

let menuList = ref<Menu[]>([
  {
    menuname: '首页',
    path: '/',
    active: true
  },
  {
    menuname: '分类',
    path: '/',
    active: false
  },
  {
    menuname: '标签',
    path: '/',
    active: false
  },
  {
    menuname: '课程',
    path: '/',
    active: false
  }
])

const scrollStore = usescrollStore()
const loginClick = () => {
  scrollStore.isVisibleLoginForm = true
}

const handleLogout = async () => {
  let res = await logout()
  userStore.$reset()
}
let router = useRouter()

//前往个人信息页面
const toUserInfo = () => {
  let { href } = router.resolve({
    name: 'user',
    params: {
      id: userStore.userInfo.id
    }
  })
  window.open(href, '_blank')
}

//设置
const toSetting = () => {
  router.push('/settings/profile')
}

const toManagement = () => {
  window.location.href = 'http://127.0.0.1:5174/layout'
}
</script>

<style scoped lang="scss">
.myheader {
  width: 100%;
  display: flex;
  background-color: var(--theme-header-bg-color);
  border-bottom: 1px solid var(--theme-border1-color);
  justify-content: center;

  .content {
    max-width: var(--content-width);
    display: flex;
    justify-content: space-between;

    height: 55px;
    color: var(--theme-text3-color);

    align-items: center;
  }

  .myheader-left {
    display: flex;
    width: 500px;

    .logo {
      margin-right: 15px;
    }
  }

  .myheader-right {
    display: flex;
    width: 500px;
    justify-content: space-evenly;
    align-items: center;

    .userinfo {
      cursor: pointer;
    }

    .notification {
      font-size: 24px;
      cursor: pointer;
      &:hover {
        color: #a6a2a2;
      }
    }

    .backstage {
      cursor: pointer;
      &:hover {
        color: #a6a2a2;
      }
    }
  }
}
</style>
