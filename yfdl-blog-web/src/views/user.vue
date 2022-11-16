<template>
  <div class="user">
    <my-content>
        <template #left>
          <user-info :id="id"></user-info>
          <user-action :id="id"></user-action>
        </template>
        <template #right>
          <user-achievements :id="id"></user-achievements>
        </template>
    </my-content>
  </div>
</template>

<script lang='ts' setup >
import {reactive, ref} from 'vue'
import MyContent from '@/components/MyContent.vue'
import UserInfo from '@/components/user/UserInfo.vue'
import UserAction from '@/components/user/UserAction.vue'
import UserAchievements from '@/components/user/UserAchievements.vue'
import {useRoute} from 'vue-router'

//获取用户id
const route=useRoute();
const id=parseInt(route.params.id as string);


</script>

<style scoped lang='scss'>
  
</style>