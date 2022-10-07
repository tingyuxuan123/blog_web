<template>
<Header>
    <template class="left" #header-left >
        <span @click="a">
            <el-icon v-if="!menuStore.isCollapse"><Fold /></el-icon>
            <el-icon v-else><Expand /></el-icon>
        </span>
    </template>

    <template #header-right>
        <div>
            <el-dropdown>
                <el-avatar :size="30" :src="userStore.userInfo?userStore.userInfo.avatar:''" />
                <el-avatar ></el-avatar>
                <template #dropdown>
                <el-dropdown-menu>
                    <el-dropdown-item @click="toUserInfo">个人资料</el-dropdown-item>
                    <el-dropdown-item @click="logout">退出登录</el-dropdown-item>
                </el-dropdown-menu>
                </template>
            </el-dropdown>
            
        </div>
    </template>

</Header>
</template>

<script lang='ts' setup >
import {reactive, ref} from 'vue'
import { UserFilled } from '@element-plus/icons-vue'
import Header from '@/components/header/header.vue';
import {usemenuStore} from '@/stores/menuStore'
import {useUserStore} from "@/stores/userStore"
import { useRouter } from 'vue-router';

let menuStore=usemenuStore()
let userStore=useUserStore()
const router=useRouter()
 
let a=()=>{
    menuStore.changeCollapse()
}

//退出登录
let logout=()=>{
    //清空用户信息
    userStore.$reset();
    router.push("/login")
    
}

let toUserInfo=()=>{
    router.push("/layout/userInfo")
}


</script>

<style scoped lang='less'>
  .el-icon{
    font-size: 28px;
  }
  .left{
    cursor: pointer;
  }
</style>