<template>
  <div class="article-user">
    <div class="left">
      <img :src="info.avatar" alt="" @click="toUser(info.id)" />
      <div class="mate">
        <div class="author-name" @click="toUser(info.id)">
          <span>{{ info.nickName }}</span>
        </div>
        <div class="article-info">
          <span class="createTime">{{ info.createTime }}</span>
          <span class="viewCount">阅读 {{ info.viewCount }}</span>
        </div>
      </div>
    </div>
    <div class="right">
      <!-- <el-button type="primary" plain>关注</el-button> -->
    </div>
  </div>
</template>

<script lang="ts" setup>
import { reactive, ref } from 'vue'
import { useRouter } from 'vue-router'

const router = useRouter()

type Props = {
  info: {
    id: number
    createBy: number
    avatar: string
    nickName: string
    categoryName: string
    viewCount: number
    createTime: string
  }
}

let props = defineProps<Props>()

//跳转到用户页面
const toUser = (id: number) => {
  router.push({
    name: 'user',
    params: {
      id
    }
  })
}
</script>

<style scoped lang="scss">
.article-user {
  display: flex;
  height: 50px;
  align-items: center;
  justify-content: space-between;

  .left {
    display: flex;
    align-items: center;

    img {
      width: 40px;
      height: 40px;
      border-radius: 999px;
      margin-right: 5px;
      cursor: pointer;
    }

    .author-name {
      cursor: pointer;
      color: var(--theme-text1-color);
    }

    .article-info {
      font-size: 12px;
      color: var(--theme-text4-color);
      margin-top: 2px;

      .viewCount {
        margin-left: 3px;
      }
    }
  }
}
</style>
