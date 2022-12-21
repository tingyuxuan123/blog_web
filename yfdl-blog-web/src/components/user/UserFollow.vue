<template>
  <div class="userfollow">
    <ul class="byfollow">
      <li>
        <span>关注</span> <span class="count">{{ userinfo.followCount }}</span>
      </li>
      <li class="border"></li>
      <li>
        <span>粉丝</span>
        <span class="count">{{ userinfo.beFollowCount }}</span>
      </li>
    </ul>

    <ul class="footer">
      <li>
        <span>收藏夹</span> <span>{{ userinfo.collectionCount }}</span>
      </li>
      <li>
        <span>加入于</span> <span>{{ userinfo.createTime }}</span>
      </li>
    </ul>
  </div>
</template>

<script lang="ts" setup>
import { reactive, ref, inject } from 'vue'
import AsideItem from '@/components/aside/asideItem.vue'
type Props = {
  id: number
}
const props = defineProps<Props>()
type UserInfoByHomePage = {
  id: number
  avatar: string
  nickName: string
  email: string
  phonenumber: string
  sex: string
  github: string
  homepage: string
  position: string
  company: string
  label: string
  isFollow: boolean
  likesCount: number
  readCount: number
  followCount: number
  beFollowCount: number
  collectionCount: number
  createTime: number
}
const userinfo = inject<UserInfoByHomePage>('userinfo')
</script>

<style scoped lang="scss">
.userfollow {
  background-color: var(--theme-bg4-color);
  padding: 20px;
  border-radius: 5px;
  box-shadow: 0 0 10px rgba($color: #000000, $alpha: 0.1);
  border-radius: 5px;

  .byfollow {
    display: flex;
    padding-bottom: 15px;
    border-bottom: 1px solid var(--theme-border3-color);
    li {
      display: flex;
      flex-direction: column;
      justify-content: center;
      align-items: center;
      flex: 1;
      .count {
        margin-top: 10px;
      }
    }
    .border {
      flex: none;
      width: 1px;
      height: 25px;
      border-right: 1px solid var(--theme-border3-color);
      padding-top: 18px;
    }
  }

  .footer {
    display: flex;
    flex-direction: column;
    line-height: 45px;
    li {
      display: flex;
      justify-content: space-between;
      border-bottom: 1px solid var(--theme-border3-color);
    }
  }
}
</style>
