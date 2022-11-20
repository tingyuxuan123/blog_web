<template>
  <div class="user">
  
    <my-content>
        <template #left>
          <user-info :id="id"></user-info>
          <user-action :id="id"></user-action>
        </template>
        <template #right>
          <user-achievements :id="id"></user-achievements>
          <user-follow :id="id"></user-follow>


        </template>
    </my-content>

  </div>
</template>

<script lang='ts' setup >
import {reactive, ref,provide} from 'vue'
import MyContent from '@/components/MyContent.vue'
import UserInfo from '@/components/user/UserInfo.vue'
import UserAction from '@/components/user/UserAction.vue'
import UserAchievements from '@/components/user/UserAchievements.vue'
import UserFollow from '@/components/user/UserFollow.vue'
import {useRoute} from 'vue-router'
import {userInfoByHomePage} from '@/api/user'
import {copy} from '@/utils/copyObject'

//获取用户id
const route=useRoute();
const id=parseInt(route.params.id as string);


type UserInfoByHomePage={
  id:number,
  avatar:string,
  nickName:string,
  email:string,
  phonenumber:string,
  sex:string,
  github:string,
  homepage:string,
  position:string,
  company:string,
  label:string,
  isFollow:boolean,
  likesCount:number,
  readCount:number,
  followCount:number,
  beFollowCount:number,
  collectionCount:number,
  createTime:number
}

let userinfo=reactive<UserInfoByHomePage>({
    id: id,
    avatar: null,
    nickName: null,
    email: null,
    phonenumber: null,
    sex: null,
    github: null,
    homepage: null,
    position: null,
    company: null,
    label: null,
    isFollow: null,
    likesCount: null,
    readCount: null,
    followCount: null,
    beFollowCount: null,
    collectionCount: null,
    createTime: null
})

provide("userinfo",userinfo)

//获取用户详情
const getUserInfoByHomePage=async ()=>{
  let res= await userInfoByHomePage(id)
  copy(res.data,userinfo);
  console.log(userinfo);
  
}

getUserInfoByHomePage();


</script>

<style scoped lang='scss'>
  
</style>