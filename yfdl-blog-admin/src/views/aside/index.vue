<template>
    <el-menu
        active-text-color="#fff"
        background-color="#001529"
        :collapse="menuStore.isCollapse"
        class="el-menu-vertical-demo"
        default-active="/layout/panel"
        text-color="#ccc"
        router="true"
        @open="handleOpen"
        @close="handleClose"
    >
        <logoVue></logoVue>

        <el-menu-item index="/layout/panel">
            <el-icon><HelpFilled /></el-icon>
            <template #title>仪表盘</template>
        </el-menu-item>
        <el-sub-menu index="2">
            <template #title>
                <el-icon><EditPen /></el-icon>
                <span>文章管理</span>
            </template>
            <el-menu-item index="/layout/allArticle">
                <el-icon></el-icon>
                <template #title>所有文章</template>
            </el-menu-item>
            <el-menu-item index="/layout/write">
                <el-icon></el-icon>
                <template #title>写文章</template> 
            </el-menu-item>
            <el-menu-item index="/layout/category">
                <el-icon></el-icon>
                <template #title>分类</template> 
            </el-menu-item>
            <el-menu-item index="/layout/span">
                <el-icon></el-icon>
                <template #title>标签</template> 
            </el-menu-item>
        </el-sub-menu>
        <el-sub-menu index="3">
            <template #title>
                <el-icon><Collection /></el-icon>
                <span>页面管理</span>
            </template>
            <el-menu-item index="/layout">
                <el-icon></el-icon>
                <template #title>所有页面</template>
            </el-menu-item>
            <el-menu-item index="/layout">
                <el-icon></el-icon>
                <template #title>新建页面</template> 
            </el-menu-item>
        </el-sub-menu>
        <el-menu-item index="/layout/comment">
            <el-icon><ChatDotRound /></el-icon>
            <template #title>评论管理</template>
        </el-menu-item>
        <el-menu-item index="/layout/imageManage">
            <el-icon><Picture /></el-icon>
            <template #title>图片管理</template>
        </el-menu-item>
        <el-sub-menu index="6">
            <template #title>
                <el-icon><User /></el-icon>
                <span>用户管理</span>
            </template>
            <el-menu-item index="/layout/userInfo">
                <el-icon></el-icon>
                <template #title>个人资料</template>
            </el-menu-item>
        </el-sub-menu>
        <el-sub-menu index="7">
            <template #title>
                <el-icon><User /></el-icon>
                <span>系统管理</span>
            </template>
            <el-menu-item index="/layout/system/menu">
                <el-icon></el-icon>
                <template #title>菜单管理</template>
            </el-menu-item>
        </el-sub-menu>
    </el-menu>
 

  </template>
  
  <script lang="ts" setup>
    import logoVue from './logo.vue';
    import {usemenuStore} from '../../stores/menuStore'

 let menuStore=usemenuStore()

  const handleOpen = (key: string, keyPath: string[]) => {
    console.log(key, keyPath)
  }
  const handleClose = (key: string, keyPath: string[]) => {
    console.log(key, keyPath)
  }
  </script>

  <style scoped>
    .el-menu{
        /* width: 250px; */
        height: 100vh;
        background-color: #001529;
    }
    .el-menu-item.is-active {
        background-color: #1890ff !important;
        color: #fff;

        }


        
  </style>

  