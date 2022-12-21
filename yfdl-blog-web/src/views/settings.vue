<template>
  <div class="profile">
    <header>
      <span class="returnUserPage" @click="returnOweHome">
        <el-icon>
          <ArrowLeft />
        </el-icon>
        返回个人主页
      </span>
    </header>

    <content>
      <div class="content-left">
        <menuVue></menuVue>
      </div>

      <div class="content-right">
        <router-view></router-view>
      </div>
    </content>
  </div>
</template>

<script lang="ts" setup>
import { useUserStore } from '@/stores/userStore'
import { reactive, ref } from 'vue'
import { useRouter } from 'vue-router'
import MyContent from '@/components/MyContent.vue'
import menuVue from '@/components/settings/menu.vue'

const userStore = useUserStore()
let userId = userStore.userInfo.id

const router = useRouter()
const returnOweHome = () => {
  router.push({
    name: 'user',
    params: {
      id: userId
    }
  })
}
</script>

<style scoped lang="scss">
.profile {
  width: var(--content-width);

  header {
    display: flex;
    padding: 0px 20px;
    box-sizing: border-box;

    span {
      display: flex;
      align-items: center;
      color: var(--theme-text4-color);
      cursor: pointer;

      &:hover {
        color: var(--theme-text-active-color);
      }
    }

    height: 50px;
    width: 100%;
    margin: 20px 0px;
    background-color: var(--theme-bg4-color);
  }

  content {
    display: flex;

    .content-left {
      width: 250px;
      height: 600px;
      background-color: var(--theme-bg4-color);
    }

    .content-right {
      margin-left: 15px;
      width: calc(100% - 250px);
      background-color: var(--theme-bg4-color);
    }
  }
}
</style>
