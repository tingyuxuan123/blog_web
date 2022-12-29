<template>
  <div class="followList">
    <ul v-if="followList.length > 0">
      <li v-for="follow in followList" :key="follow.id">
        <div class="left">
          <div class="userImg">
            <img :src="follow.avatar" alt="" />
          </div>
          <div class="info">
            <h2 class="name">{{ follow.nickName }}</h2>
            <p class="label">{{ follow.label }}</p>
            <div class="likes">
              <span> 获得 {{ follow.likesCount }} 赞</span>
              <span> {{ follow.readCount }} 阅读</span>
            </div>
          </div>
        </div>

        <div class="followBtn">
          <el-button type="primary" plain @click="handleFollow(follow.id)">
            {{ isFollow(follow.id) ? '已关注' : '关注' }}</el-button
          >
        </div>
      </li>
    </ul>
    <el-empty v-else description="暂无数据" />
  </div>
</template>

<script lang="ts" setup>
import { onMounted, reactive, ref } from 'vue'
import { followApi, followListApi } from '@/api/follow'
import { useUserStore } from '@/stores/userStore'
import { follow } from '@/utils/utils'
type Props = {
  id: number
}

type FollowInfo = {
  avatar?: string
  id?: number
  label?: string
  nickName?: string
  likesCount?: number
  readCount?: number
}

const followList = ref<FollowInfo[]>([])

const userStore = useUserStore()

const isFollow = (id: number) => {
  if (userStore.followIds.indexOf(id) === -1) {
    return false
  } else {
    return true
  }
}

const props = defineProps<Props>()
console.log(props.id)

const getFollowList = async () => {
  const res: any = await followListApi(props.id)
  followList.value = res.data
}

const handleFollow = async (id: number) => {
  await follow(id)
}

// const handleFollow = async (isFollow: boolean, id: number) => {
//   if (!isLogin()) {
//     return
//   }

//   if (isFollow) {
//     //取消关注
//     userStore.followIds.splice(userStore.followIds.indexOf(id), 1)
//   } else {
//     //添加关注
//     userStore.followIds.push(id)
//   }
//   let res = await followApi(id)
// }

onMounted(() => {
  getFollowList()
})
</script>

<style scoped lang="scss">
ul {
  li {
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding: 10px 15px;

    border-bottom: 1px solid rgba(178, 186, 194, 0.15);

    .left {
      display: flex;
      align-items: center;
    }

    .userImg {
      margin-right: 20px;
      img {
        width: 60px;
        height: 60px;
        border-radius: 888px;
      }
    }
    .info {
      .name {
        color: #7dbaff;
        /* color: #1e80ff; */
      }
      .label,
      .likes {
        color: #b9c0c8;
        font-size: 14px;
      }
    }

    .el-button {
      width: 80px;
    }
  }
}
</style>
