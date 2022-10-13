<template>
    <el-menu
        active-text-color="#fff"
        background-color="#001529"
        :collapse="menuStore.isCollapse"
        class="el-menu-vertical-demo"
        :default-active="defaultActive"
        text-color="#ccc"
        :router="false"
        @open="handleOpen"
        @close="handleClose"
    >
        <logoVue></logoVue>
        <DynamicMenus></DynamicMenus>

    </el-menu>


  </template>
  
  <script lang="ts" setup>
    import {computed} from 'vue'
    import logoVue from './logo.vue';
    import {usemenuStore} from '../../stores/menuStore'
    import DynamicMenus from '../../components//header/dynamicMenus.vue'
    import {useRoute} from "vue-router"

    let menuStore=usemenuStore()
    let route = useRoute();
    
    let defaultActive=computed(()=>{
        console.log(route.fullPath);
        
        return route.fullPath
    })


  const handleOpen = (key: string, keyPath: string[]) => {
    // console.log(key, keyPath)
  
}
  const handleClose = (key: string, keyPath: string[]) => {
    // console.log(key, keyPath)

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

  